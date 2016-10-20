package patientMember;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import common.DBconn;

public class PatientMemberDAO {
	public String sapCheck(String sapNum){
		String result="";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			conn = DBconn.conn();
			String sql="SELECT COUNT(*) AS 'sapCount' FROM hospital.patient WHERE sapNum=?;";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,sapNum);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(rs.getInt("sapCount")!= 0){
					result="�̹� ��ϵ� ���׹�ȣ�Դϴ�. Ȯ�����ֽñ� �ٶ��ϴ�.";
				}
				else{
					result="��� ������ ���׹�ȣ�Դϴ�.";
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
