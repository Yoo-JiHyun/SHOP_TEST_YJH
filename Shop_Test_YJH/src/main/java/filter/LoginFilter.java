package filter;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import shop.dao.UserRepository;
import shop.dto.PersistentLogin;
import shop.dto.User;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter("/LoginFilter")
public class LoginFilter extends HttpFilter implements Filter {
	
	PersistentLogin persistentLogin;
	UserRepository userRepository;
	
	public LoginFilter() {
		super();
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		Cookie[] cookies = httpRequest.getCookies();
		
		String rememberMe = null;
		String token = null;
		
		if( cookies != null ) {
			for( Cookie cookie : cookies ) {
				String cookieName = cookie.getName();
				String cookieValue = URLDecoder.decode( cookie.getValue(), "UTF-8");
				switch (cookieName) {
				case "rememberMe"	: rememberMe = cookieValue;	break;
				case "token"		: token = cookieValue;	break;

				}
			}
		}
		System.out.println("LoginFilter...");
		System.out.println("rememberMe : " + rememberMe);
		System.out.println("token : " + token);
		
		HttpSession session = httpRequest.getSession();
		String loginId = (String) session.getAttribute("loginId");
		
		if ( loginId != null ) {
			chain.doFilter(request, response);
			System.out.println("로그인 된 사용자" + loginId);
			return;
		}
		
		if ( rememberMe != null && token != null ) {
			PersistentLogin persistentLogin = userRepository.selectToken(token);
			
			if ( persistentLogin != null ) {
				loginId = persistentLogin.getUserId();
				
				session.setAttribute("loginId", loginId);
				System.out.println("자동 로그인 성공 : " + loginId);
		}
	}
		chain.doFilter(request, response);
}
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		super.destroy();
	}
	
	
	
}
