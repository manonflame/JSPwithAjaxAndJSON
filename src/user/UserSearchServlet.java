package user;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserSearchServlet")
public class UserSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); //udf-8으로 매개변수를 인코딩함 : 매개변수란 userSearchServle으로 넘어오는 매변수를 말한다.
		response.setContentType("text/html;charset=UTF-8");
		String userName = request.getParameter("userName");
		response.getWriter().write(getJSON(userName));
	}  
	 
	//검색한 정보가 json형태로 출력되도록 함.
	public String getJSON(String userName) {
		if(userName == null) userName ="";
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		UserDAO userDAO = new UserDAO();
		ArrayList<User> userList = userDAO.search(userName);
		for(int i= 0; i < userList.size(); i++) {
			result.append("[{\"value\": \"" + userList.get(i).getUserName()+"\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserName()+"\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserName()+"\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserName()+"\"}],");
		}
		result.append("]}");
		return result.toString();
	}

}
