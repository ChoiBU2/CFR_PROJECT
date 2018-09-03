package com.cfr.web.favorite.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Conditional;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cfr.web.favorite.service.FavoriteService;
import com.cfr.web.member.service.MemberService;

@Controller
public class FavoriteController {
	private static final Logger logger = LoggerFactory.getLogger(FavoriteController.class);
	@Autowired
	FavoriteService favoriteService;
	@Autowired
	MemberService memberService;

	// 선호기업 등록
	@RequestMapping(value = "/favorite/regist", method = { RequestMethod.GET, RequestMethod.POST })
	public String regist(@RequestParam Map map, Model model, HttpSession session) {
		if (session.getAttribute("f_id") == null) {
			String id = (String) session.getAttribute("m_id");
			if (id == null) {
				return "/member/loginForm";
			}
			System.out.println(map);
			Map m_id = new HashMap();
			m_id.put("m_id", id);
			System.out.println("2212233333333");
			map.put("m_no", memberService.select(m_id).get("m_no"));
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@" + map);
			// System.out.println("회원 정보입니다 " +
			// model.addAllAttributes(memberService.select(map)));
			// System.out.println("2222222222");
			// model.addAttribute(arg0)

			int result = favoriteService.select(map);
			System.out.println("결과값은 짜짠!" + result);
			if (result == 0) {
				favoriteService.regist(map);
				System.out.println(map);
				System.out.println("선호기업 등록완료");

			} else if (result != 0) {
				System.out.println("이미 등록된 선호기업");
			}

			// 성공시 화면 바꿔야함
			model.addAttribute("forward_url", "/");
			model.addAttribute("flag", result + 1);
			model.addAttribute("msg", "등록");
		}

		if (session.getAttribute("m_id") == null) {
			String id = (String) session.getAttribute("f_id");
			if (id == null) {
				return "/member/loginForm";
			}
			System.out.println(map);
			Map f_id = new HashMap();
			f_id.put("f_id", id);
			map.put("f_no", memberService.select(f_id).get("f_no"));

			int result = favoriteService.select(map);
			System.out.println("결과값은 짜짠!" + result);
			if (result == 0) {
				favoriteService.regist(map);
				System.out.println(map);
				System.out.println("선호기업 등록완료");

			} else if (result != 0) {
				System.out.println("이미 등록된 선호기업");
			}

			// 성공시 화면 바꿔야함
			model.addAttribute("forward_url", "/");
			model.addAttribute("flag", result + 1);
			model.addAttribute("msg", "등록");
		}
		return "/alert/alert";
	}

	// 선호기업 리스트
	@RequestMapping(value = "/favorite/favorite")
	public String favorite(Model model, @RequestParam Map map, HttpSession session) {
		if (session.getAttribute("m_id") == null) {
			String id = (String) session.getAttribute("f_id");
			System.out.println("하나 가져온 회원번호는 " + id);
			if (id == null) {
				return "/member/loginForm";
			}
			map.put("f_id", id);
			map = (Map) model.addAllAttributes(memberService.select(map));

			List list = favoriteService.favorite(map);
			System.out.println(list);

			model.addAttribute("list", list);
			return "/favorite/favorite";
		} else if (session.getAttribute("f_id") == null) {
			String id = (String) session.getAttribute("m_id");
			System.out.println("하나 가져온 회원번호는 " + id);

			if (id == null) {
				return "/member/loginForm";
			}
			map.put("m_id", id);
			map = (Map) model.addAllAttributes(memberService.select(map));

			List list = favoriteService.favorite(map);
			System.out.println(list);
			model.addAttribute("list", list);
			return "/favorite/favorite";
		}
		return "/favorite/favorite";
	}

	@RequestMapping(value = "/favorite/delete", method = RequestMethod.GET)
	@ResponseBody
	public String delete(Locale locale, Model model, @RequestParam Map map, HttpSession session) {
		if (session.getAttribute("f_id") == null) {
			String id = (String) session.getAttribute("m_id");
			Map m_id = new HashMap();
			m_id.put("m_id", id);
			map.put("m_no", memberService.select(m_id).get("m_no"));
			try {
				if (1 == favoriteService.delete(map)) {
					return "1";
				} else {
					return "0";
				}
			} catch (Exception e) {
				logger.error("오류발생~~~~~~~~~", e);
				return "0";
			}
		} else if (session.getAttribute("m_id") == null) {
			String id = (String) session.getAttribute("f_id");
			Map f_id = new HashMap();
			f_id.put("f_id", id);
			map.put("f_no", memberService.select(f_id).get("f_no"));
			try {
				if (1 == favoriteService.delete(map)) {
					return "1";
				} else {
					return "0";
				}
			} catch (Exception e) {
				logger.error("오류발생~~~~~~~~~", e);
				return "0";
			}
		}
		return "";

	}
}

