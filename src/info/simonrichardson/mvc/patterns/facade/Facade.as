package info.simonrichardson.mvc.patterns.facade
{
	import info.simonrichardson.errors.NullReferenceError;
	import info.simonrichardson.mvc.ICommand;
	import info.simonrichardson.mvc.IController;
	import info.simonrichardson.mvc.IFacade;
	import info.simonrichardson.mvc.IMediator;
	import info.simonrichardson.mvc.IModel;
	import info.simonrichardson.mvc.IProxy;
	import info.simonrichardson.mvc.IView;
	import info.simonrichardson.mvc.core.Controller;
	import info.simonrichardson.mvc.core.Model;
	import info.simonrichardson.mvc.core.View;

	import org.osflash.signals.ISignal;

	/**
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public class Facade implements IFacade
	{
		
		protected var controller : IController;
		
		protected var model : IModel;
		
		protected var view : IView;
		
		public function Facade()
		{
			initFacade();
		}
		
		private function initFacade() : void
		{
			initializeView();
			initializeModel();
			initializeController();
		}
		
		protected function initializeView() : void
		{
			if(null != view)
			{
				throw new NullReferenceError();
			}
			view = new View();
			view.initialize(this);
		}
		
		protected function initializeModel() : void
		{
			if(null != model)
			{
				throw new NullReferenceError();
			}
			model = new Model();
			model.initialize(this, view);
		}
		
		protected function initializeController() : void
		{
			if(null != controller)
			{
				throw new NullReferenceError();
			}
			controller = new Controller();
			controller.initialize(this, view);
		}

		public function registerProxy(proxy : IProxy) : void
		{
			if(null == model)
			{
				throw new NullReferenceError();
			}
			model.registerProxy(proxy);
		}

		public function retrieveProxy(proxyName : String) : IProxy
		{
			if(null == model)
			{
				throw new NullReferenceError();
			}
			return model.retrieveProxy(proxyName);
		}

		public function removeProxy(proxyName : String) : IProxy
		{
			if(null == model)
			{
				throw new NullReferenceError();
			}
			return model.removeProxy(proxyName);
		}

		public function hasProxy(proxyName : String) : Boolean
		{
			if(null == model)
			{
				throw new NullReferenceError();
			}
			return model.hasProxy(proxyName);
		}

		public function registerCommand(command : ICommand) : void
		{
			if(null == controller)
			{
				throw new NullReferenceError();
			}
			controller.registerCommand(command);
		}

		public function removeCommand(command : ICommand) : void
		{
			if(null == controller)
			{
				throw new NullReferenceError();
			}
			controller.removeCommand(command);
		}

		public function hasCommand(commandName : String) : Boolean
		{
			if(null == controller)
			{
				throw new NullReferenceError();
			}
			return controller.hasCommand(commandName);
		}

		public function registerMediator(mediator : IMediator) : void
		{
			if(null == view)
			{
				throw new NullReferenceError();
			}
			view.registerMediator(mediator);
		}

		public function retrieveMediator(mediatorName : String) : IMediator
		{
			if(null == view)
			{
				throw new NullReferenceError();
			}
			return view.retrieveMediator(mediatorName);
		}

		public function removeMediator(mediatorName : String) : IMediator
		{
			if(null == view)
			{
				throw new NullReferenceError();
			}
			return view.removeMediator(mediatorName);
		}

		public function hasMediator(mediatorName : String) : Boolean
		{
			if(null == view)
			{
				throw new NullReferenceError();
			}
			return view.hasMediator(mediatorName);
		}

		public function getSignal(signalName : String) : ISignal
		{
			if(null == view)
			{
				throw new NullReferenceError();
			}
			return view.getSignal(signalName);
		}

		public function get name() : String
		{
			return "Facade";
		}
	}
}
