<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/headerScript.jsp" %>
<html>
<head>
	<title>Home</title>
	<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
	<style type="text/css">
		body{background:url('../resources/images/bgimage.jpg') 
		no-repeat center center fixed; -webkit-background-size: cover;-moz-background-size: cover;
		-o-background-size: cover;background-size: cover;} 
		p,h1,h2,h3,h4{color:white;}
	</style>
<!-- 자동완성 -->
<script type="text/javascript">
	$(function(){	
	    $( "#searchWord" ).autocomplete({
	        source : function( request, response) {
	             $.ajax({
	                    type: 'post',
	                    url: "/corporation/select_c_name",
	                    dataType: "json",
	                    data: { search : request.term },
	                    success: function(data) {
	                        //서버에서 json 데이터 response 후 목록에 뿌려주기 위함
	                        response(
	                            $.map(data, function(item) {
	                                return {
	                                    label: item.c_name,
	                                    value: item.c_name
	                                }
	                            })
	                        );
	                    }
	               });
	            },
	        //조회를 위한 최소글자수
	        minLength: 1
	    });
	})
</script>
<!-- 랜덤검색 -->
<script type="text/javascript">
	function randomSearch(){
		var rand = Math.floor(Math.random() * 1448) + 1;
		var form = document.createElement("form");
	    form.setAttribute("method", 'post');
	    form.setAttribute("action", '/corporation/search');
	        var hiddenField = document.createElement("input");
	        hiddenField.setAttribute("type", "hidden");
	        hiddenField.setAttribute("name", "c_no");
	        hiddenField.setAttribute("value", rand);
        form.appendChild(hiddenField);
	    document.body.appendChild(form);
	    form.submit();
	}
</script>

<!-- 문의하기 모달 -->
<!-- <script type="text/javascript">
	$('#myModal').on('shown.bs.modal', function () {
		$('#myInput').focus()
	})
</script> -->

</head>

<body>
<div class="container">
<br>
	<div>
		<h1 class="white-font bold top-margin">당신의 미래를 지금 검색하세요</h1>
		<form class="form-inline" action="/corporation/search" method="POST">
			<input class="form-control"  type="text" id="searchWord" name="c_name" size="50" placeholder="회사명을 입력하세요"  >
			<!-- <input class="btn btn-default" type="submit" id="btnSearch"  value="search" >
			<input class="btn btn-secondary" type="button"  onclick="randomSearch()" value="랜덤"> -->
	
			<button type="submit" class="btn btn-default btn-md">
				<span class="glyphicon glyphicon-search" aria-hidden="true"></span>&nbsp;&nbsp;검색
			</button>
			<button type="button" class="btn btn-default btn-md" onclick="randomSearch()" >
			  <span class="glyphicon glyphicon-random" aria-hidden="true"></span>&nbsp;&nbsp;랜덤검색
			</button>		
		</form>
	</div>
<br>
<div class="container">
				<a class="btn btn-primary btn-lg top-margin font-bigger" data-toggle="modal" data-target="#myModal"><i class="fa fa-question fa-fw"></i> 문의</a>
				<c:if test="${m_id eq null && f_id eq null}">
				<a href="/member/loginForm" class="btn btn-default btn-lg top-margin left-margin font-bigger hover"><i class="fa fa-key fa-fw"></i> 로그인</a>
				</c:if>	
				
				<h2 class="white-font bold top-margin">사용기술과 프레임워크</h2>
				<div class="col-md-2">
					<p class="white-font bold">WAS</p>
					<p class="white-font bold">호스트</p>
					<p class="white-font bold">DBMS</p>
					<p class="white-font bold">툴</p>		
					<p class="white-font bold">백엔드</p>		
					<p class="white-font bold">프론트엔드</p>		
					<p class="white-font bold">기타</p>		
					<p class="white-font bold">API</p>		
					<p class="white-font bold">개발내용</p>		
					<p class="white-font bold">기타사항</p>
				</div>
				<div class="col-md-10">
					<p class="white-font">톰켓 8.5</p>
					<p class="white-font">AWS</p>
					<p class="white-font">MySQL 5.6.37</p>
					<p class="white-font">STS, phpMyAdmin, POSTMAN</p>
					<p class="white-font">Spring, MyBatis</p>
					<p class="white-font">SASS(CSS), Javascript, jQuery</p>
					<p class="white-font">Bootstrap, MomentJS, FullpageJS</p>
					<p class="white-font">구글 로그인연동, 네이버 파파고번역</p>
					<p class="white-font">다국어기능, 검색, 예매, 영화상세정보, 타 서비스(구글) 로그인 연동</p>
					<p class="white-font">다국어 기능 지원을 위한 데이터베이스 설계의 개념을 구상하기가 어려웠음</p>
					
				</div>
				
			</div>

<div class="modal fade"  id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">CFR에 문의하기</h4>
      </div>
      <div class="modal-body">
      
      	<form class="form-horizontal" method="post" action="/question/regist">
		  <div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
		    <div class="col-sm-10">
				<input type="email" class="form-control" name="q_email" placeholder="답변받을 E-mail을 입력하세요." required>
		    </div>
		   </div>
		   
		   <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">제목</label>
		    <div class="col-sm-10">
		    	<select name=q_category class="form-control">
				  <option>----------문의사항선택----------</option>
				  <option value="1">미등록 기업에 대한 정보를 요청합니다.</option>
				  <option value="2">기업 정보 수정을 요청합니다.</option>
				  <option value="3">건의 및 개선사항이 있습니다.</option>
				  <option value="9">기타 문의입니다.</option>
				</select>
		    </div>
		   </div>
		   
		   <div class="form-group">
		    <label class="col-sm-2 control-label">내용</label>
		    <div class="col-sm-10">
		    	<textarea class="form-control" name="q_contents" rows="5" placeholder="문의 내용을 입력하세요." required></textarea>
		    </div>
		    
		  </div>
		
        
     
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	        <button type="submit" class="btn btn-primary">전송</button>
	      </div>
      </form>
       </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</div>

</body>
</html>
