package member;
import java.sql.*;

import common.DBconn;
public class MemberDAO {
	//���̵� �ߺ� üũ �޼ҵ�
	public String idCheck(String nurseid){
		String result="";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			conn = DBconn.conn();
			String sql="SELECT COUNT(*) AS 'idCount' FROM hospital.nurse WHERE id=?;";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,nurseid);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(rs.getInt("idCount")!= 0){
					result="�̹� ��ϵ� ��ȣ�� ���̵��Դϴ�.";
				}
				else{
					result="��� ������ ��ȣ�� ���̵��Դϴ�.";
				}
				
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
			if( rs!=null )rs.close();
			conn.close();
			}
			
		catch(Exception e1){
			e1.printStackTrace();
		}
			
		}
		
		return result;
	}

}
