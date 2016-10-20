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
					result="이미 등록된 수액번호입니다. 확인해주시길 바랍니다.";
				}
				else{
					result="등록 가능한 수액번호입니다.";
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
