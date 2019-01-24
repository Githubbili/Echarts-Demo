package com.controller;

import com.entity.Account;
import com.mapper.EchartsMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
public class LoginController {
    @Resource
	EchartsMapper accountMapper;
    @RequestMapping("/loginController/list.do")
    public ModelAndView queryStudent(ModelAndView mv, ModelMap model) {
		List<Account> resultList = this.accountMapper.query(null);
		mv.addObject("resultList",resultList);
		mv.setViewName("list");
		return mv;
    }

	@RequestMapping("/loginController/update.do")
	public void queryStudent( HttpServletResponse response, String pass, String user,Integer type)throws IOException {
		Account account=null;
    	if(type==null){
			 account = this.accountMapper.getUser(user);
			account.setPassword(pass);
			this.accountMapper.update(account);
		}else if(type==2){
			 account = new Account();
			 account.setPassword(pass);
			 account.setUser(user);
			 this.accountMapper.insert(account);
		}

		response.getWriter().println(1);
	}

    @RequestMapping("/loginController/login.do")
    public void login(String pass, String user, RedirectAttributes attr, ModelAndView mv, Model model, HttpServletResponse response) throws IOException {
        Account account = this.accountMapper.select(user,pass);
		model.addAttribute("param", "需要传递的参数");
        if(account!=null){
			attr.addFlashAttribute("name","YES");
			response.getWriter().print(2);
        } else {
			attr.addFlashAttribute("name","BNO");
			response.getWriter().print(1);
        }
    }
    @RequestMapping("/")
    public ModelAndView login0(ModelAndView mv){
            mv.setViewName("login");
        return mv;
    }
}
