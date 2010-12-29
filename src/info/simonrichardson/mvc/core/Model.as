package info.simonrichardson.mvc.core
{
	import info.simonrichardson.mvc.IFacade;
	import info.simonrichardson.mvc.IModel;
	import info.simonrichardson.mvc.IProxy;
	import info.simonrichardson.mvc.IView;

	import flash.utils.Dictionary;

	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public class Model implements IModel
	{

		protected var view : IView;
		
		protected var facade : IFacade;

		protected var proxyMap : Dictionary;

		public function Model()
		{
		}

		public function initialize(facade : IFacade, view : IView) : void
		{
			proxyMap = new Dictionary(true);

			this.view = view;
			this.facade = facade;
		}

		public function registerProxy(proxy : IProxy) : void
		{
			if (hasProxy(proxy.name))
			{
				removeProxy(proxy.name);
			}

			proxy.initialize(facade, view);

			proxyMap[ proxy.name ] = proxy;

			proxy.onRegister();
		}

		public function retrieveProxy(proxyName : String) : IProxy
		{
			return proxyMap[ proxyName ];
		}

		public function removeProxy(proxyName : String) : IProxy
		{
			const proxy : IProxy = proxyMap[ proxyName ];
			if ( null != proxy )
			{
				delete proxyMap[ proxyName ];
				proxy.onRemove();
			}

			return proxy;
		}

		public function hasProxy(proxyName : String) : Boolean
		{
			return proxyMap[ proxyName ] != null;
		}
	}
}
