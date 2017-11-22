package{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.globalization.CurrencyFormatter;
	
	public class Data{
		var aud:Number = new Number();
		var cad:Number = new Number();
		var eur:Number = new Number();
		var gbp:Number = new Number();
		public function Data() {
			var urlRequest:URLRequest  = new URLRequest('http://apilayer.net/api/live?access_key=04cafe23b429ab6f74589334a3089938');

			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, completeHandler);
			urlLoader.load(urlRequest);

		}

		private function completeHandler(event:Event):void {
			var loader:URLLoader = URLLoader(event.target);
			var data:Object = JSON.parse(loader.data);
			aud = data.quotes.USDAUD;
			cad = data.quotes.USDCAD;
			eur = data.quotes.USDEUR;
			gbp = data.quotes.USDGBP;
			/*trace("The Australian Dollar is worth " + aud + " US Dollars");
			trace("The Canadian Dollar is worth " + cad + " US Dollars");
			trace("The Euro is worth " + eur + " US Dollars");
			trace("The British Pound is worth " + gbp + " US Dollars");
		*/}
	}
}
