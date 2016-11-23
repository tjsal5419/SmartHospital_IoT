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
		// 통신할 포트를 지정해준다.
	}

	public void run(){
		
		// 3343 포트를 통해 소켓을 주고 받음
		System.out.println("Waiting for connection on port "+port);
		
			while(true) {	
							
				try
				{
				Connection conn=null;
				Statement stmt=null;
				ResultSet rs=null;
					
				// 통신할 데이터그램 패킷 설정
				byte[] inbuf = new byte[5];
				DatagramPacket packet = new DatagramPacket(inbuf, inbuf.length);
				socket.receive(packet);
				
					
				System.out.println("Connected");		
				
				// 수신된 데이터 출력
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(URL,USER,PASS);	
					
				recvMsg=new String(packet.getData(),0,packet.getLength());
				
					
				Date today = new Date();
				sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				sapDate=sdf.format(today);
				System.out.println(sapDate);
				
				if(recvMsg.contains("/")){ //수액양 받은 경우
				piNum = recvMsg.substring(0, 3);
				sapAmount = recvMsg.substring(4, 5);
				System.out.println(piNum+"="+sapAmount);
				
				// 받아온 수액 양을 DB에 저장하기 위한 절차
				String sql="SELECT * FROM hospital.patient WHERE sapNum='"+piNum+"';";
				stmt=conn.createStatement();
				rs = stmt.executeQuery(sql);
				
	    		System.out.println(recvMsg);
	    		
				if(sapAmount.equals("3")){
					System.out.println(piNum+"의 수액 양이 충분합니다.");
					
				}
				else if(sapAmount.equals("2")){
					System.out.println(piNum+"수액 양이 적당합니다.");
				}
				else if(sapAmount.equals("1")) {
					System.out.println(piNum+"수액 양이 부족합니다. 교체해주세요");
				}	
				
				if(rs.next()){
				 if(rs.getString("switch").equals("1")){
					
					// 등록된 환자 정보에 날짜 기록이 없는 경우에만 DB 저장
					if(rs.getString("sapDate")==null){
						sql="UPDATE hospital.patient SET sapAmount='"+sapAmount+"',sapDate='"+sapDate+"' WHERE sapNum='"+piNum+"';";
						stmt.executeUpdate(sql);		
					}
					else{
						sql="UPDATE hospital.patient SET sapAmount='"+sapAmount+"' WHERE sapNum='"+piNum+"';";
						stmt.executeUpdate(sql);	
					}
					
					// 송신을 위한 datagram ip 주소 반환
					String ia = (packet.getAddress()).getHostAddress();
					InetAddress inet = InetAddress.getByName(ia);
					//송신을 위한 datagram 포트번호 반환
					System.out.println(inet);
					int sendPort = socket.getLocalPort();
					System.out.println(sendPort);
					
					String sendMsg = "noterror";
					byte[] sendMsgByte = sendMsg.getBytes();

			
					DatagramPacket sendPacket=new DatagramPacket(sendMsgByte, sendMsgByte.length, inet, recv_port);
					socket.send(sendPacket);
					System.out.println("send");
					
				}}else{
					System.out.println(piNum+"은 등록되지 않은 수액번호입니다.");
					
					String ia = (packet.getAddress()).getHostAddress();
					InetAddress inet = InetAddress.getByName(ia);
					//송신을 위한 datagram 포트번호 반환
					System.out.println(inet);
					int sendPort = socket.getLocalPort();
					System.out.println(sendPort);
					
					String sendMsg = "error";
					byte[] sendMsgByte = sendMsg.getBytes();

			
					DatagramPacket sendPacket=new DatagramPacket(sendMsgByte, sendMsgByte.length, inet, recv_port);
					socket.send(sendPacket);
					System.out.println("send");
				
				}
				
				}else if(recvMsg.contains("-")) //스위치 상태 받은 경우
				{
					swNum = recvMsg.substring(0, 3);
					sw = recvMsg.substring(4, 5);
					
					
					String sql = "SELECT count(*) AS counter FROM hospital.patient WHERE sapNum="+swNum;
					stmt=conn.createStatement();
					rs = stmt.executeQuery(sql);
					
					while(rs.next()){
						if(rs.getString("counter").equals("0")){
							if(sw.equals("1")){
							System.out.println(swNum+"은 등록되지 않은 수액번호입니다.");
							
							String ia = (packet.getAddress()).getHostAddress();
							InetAddress inet = InetAddress.getByName(ia);
							//송신을 위한 datagram 포트번호 반환
							System.out.println(inet);
							int sendPort = socket.getLocalPort();
							System.out.println(sendPort);
							
							String sendMsg = "error";
							byte[] sendMsgByte = sendMsg.getBytes();

					
							DatagramPacket sendPacket=new DatagramPacket(sendMsgByte, sendMsgByte.length, inet, recv_port);
							socket.send(sendPacket);
							System.out.println("error");
							}
							else System.out.println("스위치가 꺼져있습니다.");
						}
						else if(rs.getString("counter").equals("1")){
							sql="UPDATE hospital.patient SET switch ="+sw+" WHERE sapNum="+swNum;
							
							stmt=conn.createStatement();
							stmt.executeUpdate(sql);
							if(sw.equals("1")){
							System.out.println(swNum+"등록된 수액번호입니다.");
							
							String ia = (packet.getAddress()).getHostAddress();
							InetAddress inet = InetAddress.getByName(ia);
							//송신을 위한 datagram 포트번호 반환
							System.out.println(inet);
							int sendPort = socket.getLocalPort();
							System.out.println(sendPort);
							
							String sendMsg = "noterror";
							byte[] sendMsgByte = sendMsg.getBytes();

					
							DatagramPacket sendPacket=new DatagramPacket(sendMsgByte, sendMsgByte.length, inet, recv_port);
							socket.send(sendPacket);
							System.out.println("noterror");
						}else if(sw.equals("0")) {
							System.out.println(swNum+"의 스위치가 꺼져있습니다.");
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
