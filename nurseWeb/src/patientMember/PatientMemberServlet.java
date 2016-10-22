package patientMember;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/patientMember/*")
public class PatientMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PatientMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURL().toString();
		System.out.println(url);
		PatientMemberDAO dao=new PatientMemberDAO();
		String sapNum=request.getParameter("sapNum");
		String result=dao.sapCheck(sapNum);
		//포워딩할 페이지의 정보 분석 객체
		
		String page="/resultCheck/patientSapCheck_result.jsp";
		// 포워드(화면전환 + 데이터전달)
		
		if(sapNum.trim().length()> 0){
		request.setAttribute("msg", result); //포워딩할 페이지의 정보 분석 객체
			if(sapNum.length()!=3){
				request.setAttribute("msg", "링거대 번호는 3자리로 입력해주세요.");
			}
		}else{
			result="등록할 링거대 번호를 입력해주세요.";
			request.setAttribute("msg",result);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(page);

		rd.forward(request, response);

		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
