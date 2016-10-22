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
		//�������� �������� ���� �м� ��ü
		
		String page="/resultCheck/patientSapCheck_result.jsp";
		// ������(ȭ����ȯ + ����������)
		
		if(sapNum.trim().length()> 0){
		request.setAttribute("msg", result); //�������� �������� ���� �м� ��ü
			if(sapNum.length()!=3){
				request.setAttribute("msg", "���Ŵ� ��ȣ�� 3�ڸ��� �Է����ּ���.");
			}
		}else{
			result="����� ���Ŵ� ��ȣ�� �Է����ּ���.";
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
