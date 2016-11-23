import java.io.IOException;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.Date;

public class UdpServer extends Thread 
{
			private DatagramSocket socket;
			String recvMsg, swNum;
			String sw;
			boolean run = true;
			String result="";
			String piNum, sapAmount;
			String URL="jdbc:mysql://localhost:3306/hospital?useUnicode=true&characterEncoding=UTF-8";
			String USER="root";
			String PASS="jspbook";
			SimpleDateFormat sdf;
			String sapDate;
			String hostname = "localhost"; 
			int port,recv_port;
			
	public UdpServer() throws SocketException{
		super();
		port=3335;
		recv_port=3336;
		socket = new DatagramSocket(port);
		// ����� ��Ʈ�� �������ش�.
	}

	public void run(){
		
		// 3343 ��Ʈ�� ���� ������ �ְ� ����
		System.out.println("Waiting for connection on port "+port);
		
			while(true) {	
							
				try
				{
				Connection conn=null;
				Statement stmt=null;
				ResultSet rs=null;
					
				// ����� �����ͱ׷� ��Ŷ ����
				byte[] inbuf = new byte[5];
				DatagramPacket packet = new DatagramPacket(inbuf, inbuf.length);
				socket.receive(packet);
				
					
				System.out.println("Connected");		
				
				// ���ŵ� ������ ���
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(URL,USER,PASS);	
					
				recvMsg=new String(packet.getData(),0,packet.getLength());
				
					
				Date today = new Date();
				sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				sapDate=sdf.format(today);
				System.out.println(sapDate);
				
				if(recvMsg.contains("/")){ //���׾� ���� ���
				piNum = recvMsg.substring(0, 3);
				sapAmount = recvMsg.substring(4, 5);
				System.out.println(piNum+"="+sapAmount);
				
				// �޾ƿ� ���� ���� DB�� �����ϱ� ���� ����
				String sql="SELECT * FROM hospital.patient WHERE sapNum='"+piNum+"';";
				stmt=conn.createStatement();
				rs = stmt.executeQuery(sql);
				
	    		System.out.println(recvMsg);
	    		
				if(sapAmount.equals("3")){
					System.out.println(piNum+"�� ���� ���� ����մϴ�.");
					
				}
				else if(sapAmount.equals("2")){
					System.out.println(piNum+"���� ���� �����մϴ�.");
				}
				else if(sapAmount.equals("1")) {
					System.out.println(piNum+"���� ���� �����մϴ�. ��ü���ּ���");
				}	
				
				if(rs.next()){
				 if(rs.getString("switch").equals("1")){
					
					// ��ϵ� ȯ�� ������ ��¥ ����� ���� ��쿡�� DB ����
					if(rs.getString("sapDate")==null){
						sql="UPDATE hospital.patient SET sapAmount='"+sapAmount+"',sapDate='"+sapDate+"' WHERE sapNum='"+piNum+"';";
						stmt.executeUpdate(sql);		
					}
					else{
						sql="UPDATE hospital.patient SET sapAmount='"+sapAmount+"' WHERE sapNum='"+piNum+"';";
						stmt.executeUpdate(sql);	
					}
					
					// �۽��� ���� datagram ip �ּ� ��ȯ
					String ia = (packet.getAddress()).getHostAddress();
					InetAddress inet = InetAddress.getByName(ia);
					//�۽��� ���� datagram ��Ʈ��ȣ ��ȯ
					System.out.println(inet);
					int sendPort = socket.getLocalPort();
					System.out.println(sendPort);
					
					String sendMsg = "noterror";
					byte[] sendMsgByte = sendMsg.getBytes();

			
					DatagramPacket sendPacket=new DatagramPacket(sendMsgByte, sendMsgByte.length, inet, recv_port);
					socket.send(sendPacket);
					System.out.println("send");
					
				}}else{
					System.out.println(piNum+"�� ��ϵ��� ���� ���׹�ȣ�Դϴ�.");
					
					String ia = (packet.getAddress()).getHostAddress();
					InetAddress inet = InetAddress.getByName(ia);
					//�۽��� ���� datagram ��Ʈ��ȣ ��ȯ
					System.out.println(inet);
					int sendPort = socket.getLocalPort();
					System.out.println(sendPort);
					
					String sendMsg = "error";
					byte[] sendMsgByte = sendMsg.getBytes();

			
					DatagramPacket sendPacket=new DatagramPacket(sendMsgByte, sendMsgByte.length, inet, recv_port);
					socket.send(sendPacket);
					System.out.println("send");
				
				}
				
				}else if(recvMsg.contains("-")) //����ġ ���� ���� ���
				{
					swNum = recvMsg.substring(0, 3);
					sw = recvMsg.substring(4, 5);
					
					
					String sql = "SELECT count(*) AS counter FROM hospital.patient WHERE sapNum="+swNum;
					stmt=conn.createStatement();
					rs = stmt.executeQuery(sql);
					
					while(rs.next()){
						if(rs.getString("counter").equals("0")){
							if(sw.equals("1")){
							System.out.println(swNum+"�� ��ϵ��� ���� ���׹�ȣ�Դϴ�.");
							
							String ia = (packet.getAddress()).getHostAddress();
							InetAddress inet = InetAddress.getByName(ia);
							//�۽��� ���� datagram ��Ʈ��ȣ ��ȯ
							System.out.println(inet);
							int sendPort = socket.getLocalPort();
							System.out.println(sendPort);
							
							String sendMsg = "error";
							byte[] sendMsgByte = sendMsg.getBytes();

					
							DatagramPacket sendPacket=new DatagramPacket(sendMsgByte, sendMsgByte.length, inet, recv_port);
							socket.send(sendPacket);
							System.out.println("error");
							}
							else System.out.println("����ġ�� �����ֽ��ϴ�.");
						}
						else if(rs.getString("counter").equals("1")){
							sql="UPDATE hospital.patient SET switch ="+sw+" WHERE sapNum="+swNum;
							
							stmt=conn.createStatement();
							stmt.executeUpdate(sql);
							if(sw.equals("1")){
							System.out.println(swNum+"��ϵ� ���׹�ȣ�Դϴ�.");
							
							String ia = (packet.getAddress()).getHostAddress();
							InetAddress inet = InetAddress.getByName(ia);
							//�۽��� ���� datagram ��Ʈ��ȣ ��ȯ
							System.out.println(inet);
							int sendPort = socket.getLocalPort();
							System.out.println(sendPort);
							
							String sendMsg = "noterror";
							byte[] sendMsgByte = sendMsg.getBytes();

					
							DatagramPacket sendPacket=new DatagramPacket(sendMsgByte, sendMsgByte.length, inet, recv_port);
							socket.send(sendPacket);
							System.out.println("noterror");
						}else if(sw.equals("0")) {
							System.out.println(swNum+"�� ����ġ�� �����ֽ��ϴ�.");
							sql="UPDATE hospital.patient SET sapDate = null WHERE sapNum="+swNum;
							stmt=conn.createStatement();
							stmt.executeUpdate(sql);
						}
												}
					}
					
				}
				
			    		
				rs.close();
				stmt.close();
				conn.close();
			    		

				
				/*
				if recvMsg.equals("end") {
					client.close();
					run = false;
				}
				*/
				
			
			}catch(Exception e){
				e.printStackTrace();
			} 
			}
	}
	
	
			public static void main(String args[])throws SocketException {
				
				UdpServer server = new UdpServer();
				server.start();
				
				
				
		}
	
	
	
}
