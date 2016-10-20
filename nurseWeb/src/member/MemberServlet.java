package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class MemberServlet
 */
//������̼��� �̿��� url mapping�̸�, member�� ajax�� ���� ���� ���丮�̴�.

@WebServlet("/member/*")
public class MemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURL().toString();
		System.out.println(url);
		MemberDAO dao=new MemberDAO();
		String nurseid=request.getParameter("nurseid");
		String result=dao.idCheck(nurseid);
		//�������� �������� ���� �м� ��ü
		
		String page="/resultCheck/idCheck_result.jsp";
		// ������(ȭ����ȯ + ����������)
		
		if(nurseid.trim().length()> 0){
		request.setAttribute("msg", result); //�������� �������� ���� �м� ��ü
		}else{
			result="���̵� �Է����ּ���.";
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
