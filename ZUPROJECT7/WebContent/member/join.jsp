<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../css/member.css"/>
<script language="javascript"
	src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">


        //아이디 중복확인
		function winopen(){

		
 				if(document.fr.id.value == null){
 					window.alert("아이디를 입력하세요");
 					document.fr.id.focus();
 					return;
 				}
 			//아이디를 입력했다면 
 			//입력한 아이디를 얻어 변수에 저장
 			var fid = document.fr.id.value;
 			//새로운 팝업창을 띄우면서 입력한 아이디를 전송함.
 			window.open("join_IDcheck.jsp?userid="+fid,"","width=400,height=200");
 				
 		};//아이디 중복확인 
 		
 		
 		/* //아이디
 		function checkId() {
		
		$.ajax({
			type: "get",
			url: "join_IDcheck.jsp",
			data: ({id: $("#id").val()}),
			success: function(data) {
				if(jQuery.trim(data) == "false") {
					$("#idCheck").css("color", "green");
					$("#idCheck").text("사용가능한 아이디입니다.");
					id_Check = true;
				} else {
					$("#idCheck").css("color", "red");
					$("#idCheck").text("이미 사용중인 아이디입니다.");
					id_Check = false;
				}
			}
		});
	} */
 		
 		
 		//비밀번호
 	function checkForm(){
 			if ($("#passwd").val() != ($("#passwd2").val())) {
 				alert("비밀번호가 일치하지 않습니다.");
 				$("#passwd").val("");
 				$("#passwd2").val("");
 				$("#passwd").focus();
 				return false;
 			}
 		 return ture;
 		}//비밀번호
 		



	//성별
	$(function() {
		$(".genderBtn[for='male']").css("background-color", "#FAF4C0");
		$(".genderBtn").on("click", function() {
			$(".genderBtn").css("background-color", "#fff");
			$(this).css("background-color", "#FAF4C0");
		});
	});//성별 
	

	//우편번호
	function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('address2').focus();
            }
        }).open();
    }//우편번호 

	
	
</script>
<title>BOOKPAGE | 회원가입 </title>
</head>
<body>
	<div class="fr">
<!-- 메인로고로 첫화면 넘어가기-->
		<div id="logo">
			<img alt="BOOKPAGE" src="../images/mainlogo.png" width="160" height="100" onclick="location.href='../index.jsp'">
		</div>
<!-- 본문내용시작 -->
	<form action="joinPro.jsp" method="post" id="join" onsubmit="return checkForm();" name="fr">
		 <input type="text" id="id" name="name" class="name" placeholder="이름" required autofocus><br>
		 <input type="text" id="name" name="id" class="id" placeholder="아이디" required>
		 <input type="button" id="btn" value="아이디중복확인" class="dup" onclick="winopen()"><br>
		 <input type="password" id="passwd" name="passwd" class="passwd" placeholder="비밀번호" required><br>
		 <input type="password" id="passwd2" name="passwd2" class="passwd2"placeholder="비밀번호 확인" required><br>
		<br>
		 <input type="text" id="age" name="age" class="age" placeholder="출생년도" required><br><br>
		<span>성별</span><br><br>
		<label for="male">
			<div id="GGender">
				<input type="radio" name="gender" id="male" value="mm" checked/>
				<label for="male" class="genderBtn">남자</label>
				<input type="radio" name="gender" id="female" value="ff"/>
				<label for="female" class="genderBtn">여자</label>
			</div>
		</label><br>
		<input type="text" id="phone" name="phone" class="phone" placeholder="휴대폰번호" required><br><br>
		<input type="text" id="email" name="email" class="email" placeholder="e-mail" required><br><br><br>
		<span>주소</span><br><br>
		<div id="post">
				<input type="text" name="postcode" id="postcode" placeholder="우편번호" class="textWithBtn" required>
				<input type="button" onclick="execDaumPostcode()" value="우편번호 검색" class="btn"><br>
				<input type="text" name="address" id="address" placeholder="주소" >
				<input type="text" name="address2" id="address2" placeholder="상세주소">
		</div>
	
		<button type="submit" class="submit" id="submit" >가입</button><br>
		<button type="reset" class="reset" id="reset">취소</button>
	</form>
<!-- 본문내용끝 -->


</body>
</html>