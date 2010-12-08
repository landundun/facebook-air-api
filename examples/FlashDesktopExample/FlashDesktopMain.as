package {
	import com.adobe.serialization.json.JSON;
	import com.facebook.graph.FacebookDesktop;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class FlashDesktopMain extends Sprite {
		
		protected static const APP_ID:String = "YOUR_APP_ID";
		protected static const APP_ORIGIN:String = "http://your.site.url.com/"; //The site URL of your application (specified in your app settings); needed for clearing cookie when logging out
		
		public function FlashDesktopMain() {	
			configUI();
		}
		
		protected function configUI():void {
			//hide the params input by default
			paramsLabel.visible = paramsInput.visible = false;			
			
			//listeners for UI
			loginToggleBtn.addEventListener(MouseEvent.CLICK, handleLoginClick, false, 0, true);
			callApiBtn.addEventListener(MouseEvent.CLICK, handleCallApiClick, false, 0, true);			
			getRadio.addEventListener(MouseEvent.CLICK, handleReqTypeChange, false, 0, true);
			postRadio.addEventListener(MouseEvent.CLICK, handleReqTypeChange, false, 0, true);
			clearBtn.addEventListener(MouseEvent.CLICK, handleClearClick, false, 0, true);
			
			//Initialize Facebook library
			FacebookDesktop.init(APP_ID, onInit);			
		}
		
		protected function onInit(result:Object, fail:Object):void {						
			if (result) { //already logged in because of existing session
				outputTxt.text = "onInit, Logged In\n";
				loginToggleBtn.label = "Log Out";
			} else {
				outputTxt.text = "onInit, Not Logged In\n";
			}
		}
		
		protected function handleLoginClick(event:MouseEvent):void {
			if (loginToggleBtn.label == "Log In") {
				var permissions:Array = ["publish_stream", "user_photos"];
				FacebookDesktop.login(onLogin, permissions);				
			} else {
				FacebookDesktop.logout(onLogout, APP_ORIGIN); 
			}
		}
		
		protected function onLogin(result:Object, fail:Object):void {
			if (result) { //successfully logged in
				outputTxt.appendText("Logged In\n");
				loginToggleBtn.label = "Log Out";
			} else {
				outputTxt.appendText("Login Failed\n");				
			}
		}
		
		protected function onLogout(success:Boolean):void {			
			outputTxt.appendText("onLogout\n");
			loginToggleBtn.label = "Log In";				
		}
		
		protected function handleReqTypeChange(event:MouseEvent):void {
			if (getRadio.selected) {			
				paramsLabel.visible = paramsInput.visible = false; 
			} else {
				paramsLabel.visible = paramsInput.visible = true; //only POST request types have params
			}
		}
		
		protected function handleCallApiClick(event:MouseEvent):void {
			var requestType:String = getRadio.selected ? "GET" : "POST";
			var params:Object = null;	
			if (requestType == "POST") {
				try {
					JSON.decode(paramsInput.text);
				} catch (e:Error) {
					outputTxt.appendText("\n\nERROR DECODING JSON: " + e.message);
				}
			}
			
			FacebookDesktop.api(methodInput.text, onCallApi, params, requestType); //use POST to send data (as per Facebook documentation)
		}
		
		protected function onCallApi(result:Object, fail:Object):void {
			if (result) {
				outputTxt.appendText("\n\nRESULT:\n" + JSON.encode(result)); 
			} else {
				outputTxt.appendText("\n\nFAIL:\n" + JSON.encode(fail)); 
			}
		}
		
		protected function handleClearClick(event:MouseEvent):void {
			outputTxt.text = "";
		}
	}
}