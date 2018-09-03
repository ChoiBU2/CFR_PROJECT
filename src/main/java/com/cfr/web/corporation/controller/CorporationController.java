package com.cfr.web.corporation.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.json.XML;
import org.json.simple.parser.ParseException;

import com.cfr.web.corporation.controller.ParserUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cfr.web.corporation.service.CorporationService;
import com.cfr.web.util.APICorInfo;
import com.cfr.web.util.APISearchNews;
import com.cfr.web.util.JsonUtil;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Controller
public class CorporationController {
	

	@Autowired CorporationService corporationService;
	
	//메인창에서 ajax로 기업이름 가져오는것
	@ResponseBody
	@RequestMapping(value = "/corporation/select_c_name", method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public String registForm(@RequestParam Map map,HttpServletRequest request) throws UnsupportedEncodingException {
		   request.setCharacterEncoding("UTF-8");
		    List list = corporationService.select(map); //result값이 포함되어 있는 emp테이블의 네임을 리턴
		    Gson gson = new Gson();

		    return gson.toJson(list);
	}
	
	//메인창에서 검색해서 이름으로 기업페이지로 넘어가는 것
	@RequestMapping(value = "/corporation/search")
	public String search(Model model, @RequestParam Map map) {
		
		if(corporationService.select(map).isEmpty()) {
			model.addAttribute("flag", 0);
			model.addAttribute("msg", "기업정보 없음 검색");
		    model.addAttribute("forward_url", "/");
			return "/alert/alert";
		}
		
		Map cor_info = (Map) corporationService.select(map).get(0);
		
		//테이블 데이터 전송 시작
		String html = ParserUtil.getHtml("http://asp1.krx.co.kr/servlet/krx.asp.XMLSise?code="+cor_info.get("cp_code"));
		JSONObject json = XML.toJSONObject(html);
		Map<String, Object> resultMap = ParserUtil.parseJsonToMap(json.toString());
		model.addAttribute("map", resultMap);
		//테이블 데이터 전송 끝
		
		//연관 기업 가져오기
		Map cor_list = new HashMap();
		cor_list.put("type_codes", cor_info.get("type_code").toString());
		cor_list.put("c_nos", cor_info.get("c_no").toString());
		
		List corList = corporationService.select(cor_list);
		Gson gson = new Gson();
		model.addAttribute("corList", gson.toJson(corList));
		
		// 종목명 가져오기
		Map type_code = new HashMap();
		type_code.put("type_code", cor_info.get("type_code").toString());
		
		// 업종평균 가져오기
		List<Map> fin_info = corporationService.selectF(type_code);
		for(Map map2 : fin_info) {
			if(map2.get("f_ratio").equals("유동비율")) {
				model.addAttribute("f1", map2);
			} else if(map2.get("f_ratio").equals("부채비율")) {
				model.addAttribute("f2", map2);
			} else if(map2.get("f_ratio").equals("비유동비율")) {
				model.addAttribute("f3", map2);
			} else if(map2.get("f_ratio").equals("매출액영업이익률")) {
				model.addAttribute("f4", map2);
			} else if(map2.get("f_ratio").equals("매출액증가율")) {
				model.addAttribute("f5", map2);
			} else if(map2.get("f_ratio").equals("현금및현금성자산비율")) {
				model.addAttribute("f6", map2);
			} else if(map2.get("f_ratio").equals("매출액순이익률")) {
				model.addAttribute("f7", map2);
			} else if(map2.get("f_ratio").equals("총자산회전율")) {
				model.addAttribute("f8", map2);
			} else if(map2.get("f_ratio").equals("재고자산회전율")) {
				model.addAttribute("f9", map2);
			} else if(map2.get("f_ratio").equals("매출채권회전율")) {
				model.addAttribute("f10", map2);
			} else if(map2.get("f_ratio").equals("매입채무회전율")) {
				model.addAttribute("f11", map2);
			}
		}
		
		cor_info.put("type", ((Map)corporationService.select(type_code).get(0)).get("type"));
		
		model.addAttribute("cor_info", cor_info);	// 기업정보 넘겨주기
		
		// cor_detail을 model에 넣어주기
		List<Map> cor_detail = corporationService.selectD(cor_info);
		for(Map map2 : cor_detail) {
			if(map2.get("title").equals("매출액")) {
				model.addAttribute("A", map2);
			} else if(map2.get("title").equals("영업이익손실")) {
				model.addAttribute("B", map2);
			} else if(map2.get("title").equals("당기순이익")) {
				model.addAttribute("C", map2);
			} else if(map2.get("title").equals("유동자산")) {
				model.addAttribute("D", map2);
			} else if(map2.get("title").equals("현금및현금성자산")) {
				model.addAttribute("E", map2);
			} else if(map2.get("title").equals("매출채권")) {
				model.addAttribute("F", map2);
			} else if(map2.get("title").equals("재고자산")) {
				model.addAttribute("G", map2);
			} else if(map2.get("title").equals("비유동자산")) {
				model.addAttribute("H", map2);
			} else if(map2.get("title").equals("자산총계")) {
				model.addAttribute("I", map2);
			} else if(map2.get("title").equals("유동부채")) {
				model.addAttribute("J", map2);
			} else if(map2.get("title").equals("매입채무")) {
				model.addAttribute("K", map2);
			} else if(map2.get("title").equals("부채총계")) {
				model.addAttribute("L", map2);
			} else if(map2.get("title").equals("자본총계")) {
				model.addAttribute("M", map2);
			}
		}
		APISearchNews searchNews = new APISearchNews();
		searchNews.setSearchText(cor_info.get("c_name").toString());
		try {
			model.addAttribute("News", searchNews.aPISearchNews());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		APICorInfo apiCorInfo = new APICorInfo();
		apiCorInfo.setSearchText((String) cor_info.get("cp_code"));
		try {
			JsonParser jsonParser = new JsonParser();
			JsonObject jsonObject = (JsonObject) jsonParser.parse(apiCorInfo.APICorInfo());
			
			Map apiCor_Info = new HashMap();
			// json객체를 맵에 put
			apiCor_Info.put("ceo_nm", jsonObject.get("ceo_nm").toString().replaceAll("\"", ""));
			apiCor_Info.put("adr", jsonObject.get("adr").toString().replaceAll("\"", ""));
			apiCor_Info.put("crp_nm_e", jsonObject.get("crp_nm_e").toString().replaceAll("\"", ""));
			apiCor_Info.put("crp_cls", jsonObject.get("crp_cls").toString().replaceAll("\"", ""));
			apiCor_Info.put("phn_no", jsonObject.get("phn_no").toString().replaceAll("\"", ""));
			apiCor_Info.put("hm_url", jsonObject.get("hm_url").toString().replaceAll("\"", ""));
			String est_dt = jsonObject.get("est_dt").toString().replaceAll("\"", "").substring(0, 4)+"년 ";
			est_dt+= jsonObject.get("est_dt").toString().replaceAll("\"", "").substring(4, 6)+"월 ";
			est_dt+= jsonObject.get("est_dt").toString().replaceAll("\"", "").substring(6, 8)+"일";
			apiCor_Info.put("est_dt", est_dt);
			
			model.addAttribute("apiCorInfo", apiCor_Info);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "/corporation/corporation";
		}
	
}
