package info.simonrichardson.mvc.patterns.proxy
{
	import info.simonrichardson.mvc.IProxy;
	import info.simonrichardson.mvc.IProxyVO;
	import info.simonrichardson.mvc.patterns.observer.SignalMap;

	import org.osflash.signals.ISignal;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class Proxy extends SignalMap implements IProxy
	{

		public static const DATA_CHANGED : String = "dataChanged";

		protected var _data : IProxyVO;

		public function Proxy(name : String, data : IProxyVO = null)
		{
			super(name);

			_data = data;
		}

		public function onRegister() : void
		{
		}

		public function onRemove() : void
		{
		}

		public function get data() : IProxyVO
		{
			return _data;
		}

		public function set data(value : IProxyVO) : void
		{
			if (_data == value)
			{
				return;
			}

			if (null != _data)
			{
				_data.dispose();
				_data = null;
			}

			_data = value;

			const signal : ISignal = getSignal(DATA_CHANGED);
			if (null != signal)
			{
				signal.dispatch(this, data);
			}
		}
	}
}
