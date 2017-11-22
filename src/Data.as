package{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.globalization.CurrencyFormatter;
	
	public class Data{
		public function Data() {
			var urlRequest:URLRequest  = new URLRequest('https://api.fixer.io/latest');

			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, completeHandler);
			urlLoader.load(urlRequest);

		}

		private static function completeHandler(event:Event):void {
			var loader:URLLoader = URLLoader(event.target);
			var data:Object = JSON.parse(loader.data);
			trace("The Australian Dollar is worth " + data.rates.AUD + " Euros");
			trace("The Canadian Dollar is worth " + data.rates.CAD + " Euros");
			trace("The United States Dollar is worth " + data.rates.USD + " Euros");
			trace("The British Pound is worth " + data.rates.GBP + " euros");
		}
	}
}
