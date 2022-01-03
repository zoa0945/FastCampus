# Weather101

## 웹 프로토콜
 - 인터넷 상에서의 통신에 필요한 규약
 - SMTP: 메일을 주고 받을 때 사용
 - FTP: 파일을 전송할 때 사용
 - HTTP: 브라우저가 웹 서버와 통신할 때 사용
  * HTML문서를 주고 받는데 쓰이는 통신 프로토콜
  * 클라이언트가 서버에 요청(request)하면 서버가 응답(response)
  * 서버와 클라이언트가 연결되어 있지 않아 응답 이후 곧바로 연결 종료 됨
  * HTTP 패킷
    1) 헤더: 보내는 사람의 주소, 받는사람의 주소, 패킷의 생명 시간
    2) 바디: 우리가 실제로 받으려고 하는 정보가 답겨 있음
 - HTTP Method
  * GET: 클라이언트가 서버에 리소스를 요청할 때 사용
  * POST: 클라이언트가 서버의 리소스를 새로 만들 때 사용
  * PUT: 클라이언트가 서버의 리소스를전체 수정 할 때 사용
  * PATCH: 클라이언트가 서버의 리소스 일부를 수정 할 때 사용
  * DELETE: 클라이언트가 서버의 리소스를 삭제 할 때 사용
  * HEAD: 클라이언트가 서버의 정상 작동 여부를 확일 할 때 사용
  * OPTIONS: 클라이언트가 서버에서 해당 URL이 어떤 메서드를 지원하는지 확인 할 때 사용
  * CONNECT: 클라이언트가 프록시를 통하여 서버와 SSL통신을 하고자 할 때 사용
    (SSL통신: 클라이언트와 서버간 공유하는 암호화키를 가지고 암호화된 데이터가 송수신 되는 방식)
  * TRACE: 클라이언트와 서버간 통신 관리 및 디버깅을 할 때 사용
 - HTTP Status
  * 100..<200: Informational: 서버가 요청을 성공적으로 수신했을 때 처리 중이라는 정보
  * 200..<300: Success: 요청을 정상적으로 처리함
  * 300..<400: Redirection: 요청을 완료하기 위해 추가 동작 필요
    브라우저가 자동으로 다른 URL로 Redirection되므로 브라우저 창에서는 표시되지 않음
    이미지 파일처럼 캐싱된 파일을 새로고침 후 확인 하면 확인 가능
  * 400..<500: Client Error: 서버가 해결할 수 없는 클라이언트 측 에러
  * 500..<600: Server Error: 서버가 클라이언트의 요청을 처리하지 못했을 때 발생
 
 ## URLSession
 - 특정한 url을 이용하여 데이터를 다운하고 업로드하기 위한 API
 - URLSessionConfiguration을 통해 생성 가능
 - 생성된 URLSession을 통해 한개 이상의 URLSessionTask를 생성
 - URLSessionTask를 통해 실제 서버와 통신 할 수 있음
 - URLSession LifeCycle
  1. Session Configuration을 결정하고 Session을 생성
  2. 통신할 URL과 Request 객체를 설정
  3. 사용한 Task를 결정하고 그에 맞는 Completion Handler나 Delegate 메서드 작성
  4. 해당 Task 실행
  5. Task완료 후 Completion Handler 클로저가 호출
 
 ## Codable
 - 자신을 변환하거나 외부 타입을 변환 가능하게 해주는 프로토콜
 - 객체에서 Codable을 채택할 경우 JSON객체를 변환하거나 JSON객체로 변환 가능
 
 ### openwhather API (openweathermap.org 참고)
