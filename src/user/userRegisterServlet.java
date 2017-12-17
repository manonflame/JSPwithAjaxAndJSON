package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/userRegisterServlet")
public class userRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); //udf-8으로 매개변수를 인코딩함 : 매개변수란 userSearchServle으로 넘어오는 매변수를 말한다.
		response.setContentType("text/html;charset=UTF-8");
		String userName = request.getParameter("userName");
		String userAge = request.getParameter("userAge");
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");
		response.getWriter().write(register(userName, userAge, userGender, userEmail) + "");
	}
	
	public int register(String userName, String userAge, String userGender, String userEmail) {
		User user = new User();
		try {
			user.setUserName(userName);
			user.setUserAge(Integer.parseInt(userAge));
			user.setUserGender(userGender);
			user.setUserEmail(userEmail);
		}
		catch(Exception e) {
			return 0;
		}
		return new UserDAO().register(user);
	}
}
