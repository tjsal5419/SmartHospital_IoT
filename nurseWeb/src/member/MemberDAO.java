package member;
import java.sql.*;

import common.DBconn;
public class MemberDAO {
	//아이디 중복 체크 메소드
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
					result="이미 등록된 간호사 아이디입니다.";
				}
				else{
					result="사용 가능한 간호사 아이디입니다.";
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
