<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="/resources/css/mycss.css" rel="stylesheet">

	<script src="//code.jquery.com/jquery-1.10.2.js"></script><!-- autocomplete -->
	<script src="/resources/js/jquery-2.1.1.min.js"></script>
	<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
   
	<script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>



		<!--autocomplete 자동완성기능위해 추가함  -->
		<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
		<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
		
		<script src="//connect.facebook.net/en_US/all.js"></script>
		
		<script type="text/javascript">
			$(function(){
			    $( "#searchWord" ).autocomplete({
			        source : function( request, response ) {
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
			
			
	   	<!-- 스크롤바 -->
<style>
       .ui-autocomplete {
            max-height: 200px;
            overflow-y: auto;
            /* prevent horizontal scrollbar */
            overflow-x: hidden;
            /* add padding to account for vertical scrollbar */
            padding-right: 20px;
        } 
</style>	
		<!-- 로딩 -->
		<style>
			#loading {
				 width: 100%;  
				 height: 100%;  
				 top: 0px;
				 left: 0px;
				 position: fixed;  
				 display: block;  
				 opacity: 0.7;  
				 background-color: #fff;  
				 z-index: 99;  
				 text-align: center; } 
			  
			#loading-image {  
				 position: absolute;  
				 top: 50%;  
				 left: 50%; 
				 z-index: 100; }
		</style>
		<script type="text/javascript">
			$(window).load(function() {    
			     $('#loading').hide();  
			    });
		</script>	
	<script>
	window.fbAsyncInit = function() {
	      // init the FB JS SDK
	      FB.init({
	        appId      : '1931434830509984', // App ID from the App Dashboard
	        status     : true, // check the login status upon init?
	        cookie     : true, // set sessions cookies to allow your server to access the session?
	        xfbml      : true  // parse XFBML tags on this page?
	      });
	    };
	function f_logout(){
		   $(document).ready(function() {
				FB.logout(function(response) {
					location.replace("/member/logout");
				});  
		   });
		}
	</script>
	<!-- 네브바 검색창 숨기기 -->
	<script type="text/javascript">
		$(document).ready(function() { 
			if(location.pathname =='/' || location.pathname =='/member/loginForm') {
				$("#search").remove();
			}
		});
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
   </head>
   <body>
   <!-- 로딩 -->
   <div id="loading"><img id="loading-image" src="/resources/images/loading.gif" alt="Loading..." /></div>
   	
      <nav class="navbar navbar-default navbar-fixed-top">
         <div class="container-fluid" id="div1">
           <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/"><strong>&nbsp;&nbsp;&nbsp;&nbsp;<img alt="logo" src="/resources/images/logo.png" width="30"></strong></a>
          </div>
         
          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
            	<div id="search">
				<form class="navbar-form" role="search" action="/corporation/search" method="POST">
					<div class="form-group" >
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input class="form-control"  type="text" id="searchWord" name="c_name" size="50" placeholder="기업명을 입력하세요"  >
					</div>
					<button type="submit" class="btn btn-default btn-md">
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span>&nbsp;&nbsp;검색
					</button>
					<button type="button" class="btn btn-default btn-md" onclick="randomSearch()" >
					  <span class="glyphicon glyphicon-random" aria-hidden="true"></span>&nbsp;&nbsp;랜덤검색
					</button>
				</form>
            	</div>
            </ul>
            <ul class="nav navbar-nav navbar-right">

			
			
             		<li><a href="/member/loginForm">LOGIN</a></li>
			
            </ul>
          </div><!-- /.navbar-collapse -->
         </div><!-- /.container-fluid -->
         </nav>
        
   </body>
</html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 
<script type="text/javascript">
var pwCheck = 0;
var idCheck = 0;

//비밀번호 일치여부확인
	function isSame() {
        var pw = document.getElementById("m_pw").value;
        var pwck = document.getElementById("pw_check").value;
       
        if(pw=='' && pwck=="" ) {
        	document.getElementById("pwsame").innerHTML = '비밀번호를 입력해주세요.';
        	document.getElementById("pwsame").style.color = 'red';
        	pwCheck = 0;
        
		} else if (pw != pwck && pwck != '') {
            document.getElementById("pwsame").innerHTML = '비밀번호가 일치하지 않습니다. 다시 입력해 주세요.';
            document.getElementById("pwsame").style.color = 'red';
            pwCheck = 0;
        
        } else if(pw==pwck) {
        	document.getElementById("pwsame").innerHTML = '비밀번호가 일치합니다.';
        	document.getElementById("pwsame").style.color = 'blue';
        	pwCheck = 1;
        }
        ableBtn();
    }

 //아이디 체크하여 중복확인.
	 function checkId() {
	     var inputed = $('#idcheck').val();
	     $.ajax({
	         data : {
	             m_id : inputed
	         },
	         url : '/member/checkId',
	         success : function(data) {
	             if(inputed=="" && data=='0') {
	                 $("#idcheck").css("background-color", "#FFCECE");
	                 idCheck = 0;
	                 document.getElementById("idchk").innerHTML = '사용하실 아이디를 입력해주세요.';
	             	 document.getElementById("idchk").style.color = 'red';
	             	 
	             } else if (data == '0') {
	                 $("#idcheck").css("background-color", "#B0F6AC");
	                 idCheck = 1;
	                 document.getElementById("idchk").innerHTML = '사용가능한 아이디입니다.';
	             	 document.getElementById("idchk").style.color = 'blue';
	             } else if (data == '1') {
	                 $("#idcheck").css("background-color", "#FFCECE");
	                 idCheck = 0;
	                 document.getElementById("idchk").innerHTML = '사용불가한 아이디입니다.';
	             	 document.getElementById("idchk").style.color = 'red';
	             }
	         }
	     });
	     ableBtn();
	 }

	function ableBtn(){
	    if(pwCheck == 0 || idCheck == 0) {
	    	$("#regist").attr("disabled", true);
	    } else {
	    	$("#regist").attr("disabled", false);
	    }
	}
	
	//test
	 function idtest() {
    	//아이디 유효성 검사 (영문소문자, 숫자만 허용)
       for (i = 0; i < document.rs.m_id.value.length; i++) {
           ch = document.rs.m_id.value.charAt(i)
           if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
               alert("아이디는 대소문자, 숫자만 입력가능합니다.")
               document.rs.m_id.value="";
               document.rs.m_id.focus()
               document.rs.m_id.select()
               return false;
           }
       }
       //아이디에 공백 사용하지 않기
       if (document.rs.m_id.value.indexOf(" ") >= 0) {
           alert("아이디에 공백을 사용할 수 없습니다.")
           document.rs.m_id.focus()
           document.rs.m_id.select()
           return false;
       }
       
   
   }

 </script>  
 <script> 
       function congratuation() {
           alert("회원가입을 횐영합니다.");
       }
 </script> 
 
 <script type="text/javascript">	// 이메일 인증
 	$(document).ready(function(){
 		$("#mailcheck").click(function(){
 			alert('aaaaaaaaaaaa');
 			$.ajax({
 				type:"post",
 				url:"/member/emailcheck",
 				data:{m_email:$("#m_email").val()}
 			}).done(function(obj){
 				alert(obj);
 				if(obj){
 				 swal({
                     title: "이메일인증!",
                     content: "input",
                     button: "인증",
                     inputPlaceholder: "Write Auth"
                   }).then((value) => {
                      $.ajax({
                         type:"post",
                         url:"",
                         data:{
                            code:value
                         }
                      }).done(function(data){
                         if(data.codecheck_flag){
                            
                         }else{
                            
                         }
                      })
                   })
 				}

 			}).fail(function(){
 				alert('ajax fail')
 			})
 		})
 	})
 </script> -->
 
  
</head>

<body>
<div class="container">
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<h1>회원가입</h1><br>
			<form name="rs" class="form-horizontal" action="/member/regist" method="post">
				<label>아이디</label><input type="text" class="form-control" name="m_id" onkeyup="idtest()" id="idcheck" oninput="checkId()" size="30" placeholder="아이디를 입력해주세요." required>
				<div id='idchk'></div>
				<label>비밀번호</label><input type="password" class="form-control" name="m_pw" id="m_pw" placeholder="비밀번호를 입력해주세요." size="30" onkeyup="isSame()" required>
				<label>비밀번호 확인</label><input type="password" class="form-control" id="pw_check" placeholder="다시 한번 입력해주세요." size="30" onkeyup="isSame()" required>
				<div id="pwsame" ></div>
				<label>회원이름</label><input type="text" class="form-control" name="m_name" size="30" required>
				<label>회원이메일</label><input type="text" class="form-control" name="m_email" id="m_email" size="30" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" placeholder="ex)cfr1120@naver.com" required>
				<input type="button" id="mailcheck" value="인증">
				
				<label>회원전화</label><input type="text" class="form-control" name="m_phone" size="30" placeholder="-를 제외한 숫자만 입력하세요." pattern="^[0-9]*$" required>		
				<!-- 주소와 우편번호를 입력할 <input>들을 생성하고 적당한 name과 class를 부여한다 -->
				<label>회원주소</label>
				<input type="button" class="btn btn-primary" id="postcodify_search_button" value="주소 검색"><br />
				<!-- <button class="btn btn-primary" id="postcodify_search_button">주소 검색</button><br /> -->
				<input type="text" name="m_p_address" class="postcodify_postcode5 form-control" value="" readonly required><br />
				<input type="text" name="m_address" class="postcodify_address form-control" value="" readonly required><br />
				<input type="text" name="" class="postcodify_extra_info form-control" value="" readonly required><br />
				<input type="text" name="m_d_address" class="postcodify_details form-control" value="" required><br />
				
				<!-- jQuery와 Postcodify를 로딩한다 -->
				<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
				<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
				
				<!-- "검색" 단추를 누르면 팝업 레이어가 열리도록 설정한다 -->
				<script> $(function() { $("#postcodify_search_button").postcodifyPopUp(); }); </script>
				<input type="submit" id="regist" class="btn btn-default" value="등록" onclick= "congratuation()">
				 
			</form>	
		</div>
		<div class="col-md-2"></div>
	</div>
</div>
</body>
</html>