package info.simonrichardson.mvc.core
{
	import info.simonrichardson.mvc.IFacade;
	import info.simonrichardson.mvc.IModel;
	import info.simonrichardson.mvc.IProxy;
	import info.simonrichardson.mvc.IView;

	import flash.utils.Dictionary;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class Model implements IModel
	{

		protected var _view : IView;
		
		protected var _facade : IFacade;

		protected var _proxyMap : Dictionary;

		public function Model()
		{
		}

		public function initialize(facade : IFacade, view : IView) : void
		{
			_proxyMap = new Dictionary(true);

			_view = view;
			_facade = facade;
		}

		public function registerProxy(proxy : IProxy) : void
		{
			if (hasProxy(proxy.name))
			{
				removeProxy(proxy.name);
			}

			proxy.initialize(_facade, _view);

			_proxyMap[ proxy.name ] = proxy;

			proxy.onRegister();
		}

		public function retrieveProxy(proxyName : String) : IProxy
		{
			return _proxyMap[ proxyName ];
		}

		public function removeProxy(proxyName : String) : IProxy
		{
			const proxy : IProxy = _proxyMap[ proxyName ];
			if ( null != proxy )
			{
				delete _proxyMap[ proxyName ];
				proxy.onRemove();
			}

			return proxy;
		}

		public function hasProxy(proxyName : String) : Boolean
		{
			return _proxyMap[ proxyName ] != null;
		}
	}
}
