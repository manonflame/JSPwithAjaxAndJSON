<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name = "viewport" content = "width-device-width, initial-scale-1">
<link rel = "stylesheet" href = "css/bootstrap.css">
<title>JSP AJAX</title>
<script src = "http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "js/bootstrap.js"></script>  
<script type = "text/javascript">
	//요청을 보내는 역할을 하는 인스턴
	var searchRequest = new XMLHttpRequest();
	var registerRequest = new XMLHttpRequest();
	function searchFunction(){
		//요청을 열어서 포스트 방식으로 userSearchServlet의 userName에 userName이라는 id에 담겨있는 내용을 보냄.
		searchRequest.open("Post", "./UserSearchServlet?userName="+ encodeURIComponent(document.getElementById("userName").value), true);
		searchRequest.onreadystatechange = searchProcess;
		searchRequest.send(null);
	}
	function searchProcess(){
		//아래의 테이블중에서 ajaxTable이라는 애를 테이블 변수로 생성
		var table = document.getElementById("ajaxTable");
		table.innerHTML="";
		//성공적으로 통신이 이루어진 경우
		if(searchRequest.readyState==4 && ready.status == 200){
			var object = eval('('+ searchRequest.responseText + ')');
			var result = object.result;
			for(var i = 0; i < result.length; i++){
				var row = table.insertRow(0);
				for(var j = 0; j < result[i].length; j++){
					var cell = row.insertCell(j);
					cell.innerHTML = result[i][j].value;
				}    
			}
		} 
			
	}
	
	function registerFunction(){
		registerRequest.open("Post", "./userRegisterServlet?userName=" + encodeURIComponent(document.getElementById("registerName").value) + 
				"&userAge=" + encodeURIComponent(document.getElementById("registerAge").value) +
				"&userGender=" + encodeURIComponent($('input[name=registerGender]:checked').val()) +
				"&userEmail=" + encodeURIComponent(document.getElementById("registerEmail").value)
				, true);
		registerRequest.onreadystatechange = searchProcess;
		registerRequest.send(null);
	}
	function registerProcess(){
		if(registerRequest.readysState == 4 && registerRequest.status == 200){
			var result = registerRequest.responseText;
			if(result != 1){
				alert("등록에 실패했습니다.");
			}
			else{
				alert("등록 성공");
				var userName = document.getElementById("userName");
				var registerName = document.getElementById("registerName");
				var registerAge = document.getElementById("registerAge");
				var registerEmail = document.getElementById("registerEmail");
				
				userName = "";
				registerName ="";
				registerAge="";
				registerEmail="";
				searchFunction();
			}
		}
	}
	
	window.onload= function(){
		searchFunction(); 
	}
</script>
</head> 
<body>
	<br>
	<div class = "container">
		<div class="form-group row pull-right">
			<div class="col-xs-8">
				<input class = "form-control" id="userName" onkeyup="searchFunction()" type="text" size="20">
			</div>
			<div class="col-xs-2">
				<button class="btn btn-primary" onclick="searchFunction();" type="button">검색</button>
			</div>
		</div>
		<table class = "table" style="text-align: center; border : ipx = solid id = #dddddd">
			<thead>
				<tr>
					<th style = "background-color: #fafafa; text-align: center;">이름</th>
					<th style = "background-color: #fafafa; text-align: center;">나이</th>
					<th style = "background-color: #fafafa; text-align: center;">성별</th>
					<th style = "background-color: #fafafa; text-align: center;">이메일</th>
				</tr>
			</thead>
			<tbody id = "ajaxTable">
			</tbody>
		</table>
	</div>
	<div class="container">
		<table class="table" style="text-align; center; border: ipx solid #dddddd">
			<thead>
				<tr>
					<th colspan="2" style = "background-color: #fafafa; text-align:center;">회원등록양식</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style = "background-color: #fafafa; text-align:center;"><h5>이름</h5></td>
					<td><input class = "form-control" type="text" id="registerName" size="20"></td>
				</tr>
				<tr>
					<td style = "background-color: #fafafa; text-align:center;"><h5>나이</h5></td>
					<td><input class = "form-control" type="text" id="registerAge" size="20"></td>
				</tr>
				<tr>
					<td style = "background-color: #fafafa; text-align:center;"><h5>성별</h5></td>
					<td>
						<div class="form-group" style="text-align: center; margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary active">
									<input type="radio" name="registerGender" autocomplete="off" value="M">Male
								</label>
								<label class="btn btn-primary">
									<input type="radio" name="registerGender" automcomplete="off" value="F">Female
								</label>
							</div>						
						</div>
					</td>
				</tr>
				<tr>
					<td style = "background-color: #fafafa; text-align:center;"><h5>이메일</h5></td>
					<td><input class = "form-control" type="text" id="registerEmail" size="20"></td>
				</tr>
				<tr>
					<td colspan="2"><button class="btn btn-primary pull-right" onclick="registerFunction();" type="button">등록</button>
				</tr>
			</tbody> 
	</div>

</body>
</html> 