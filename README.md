간단한 일정관리를 할 수 있는 웹서비스

1. -메인에 접속 시, 전체 일정을 볼 수 있는 달력과 
   회원들의 금일 일정을 확인할 수 있습니다.

   -해당 일정 클릭 시, 일정 세부사항을 확인할 수 있습니다.

2. -전체일정 탭을 클릭하면 모든 회원들의 일정을 게시판형식으로
   확인할 수 있습니다.
   -각 일정이름 클릭 시, 일정 세부사항을 확인할 수 있습니다.

(일정 추가, 수정, 삭제 등은 로그인 혹은 회원가입 후 로그인을 통해
실행 가능합니다.)
---------------------------------------------------------
Info) mysql컨테이너-tomcat컨테이너로 구성된 웹서비스입니다.

Usage)
git clone 하신 뒤,
docker-compose up 을 쓰면 자동 구축됩니다.
웹서비스 주소 == localhost:8004
