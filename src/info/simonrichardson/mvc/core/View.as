package info.simonrichardson.mvc.core
{
	import info.simonrichardson.mvc.IFacade;
	import info.simonrichardson.mvc.IHook;
	import info.simonrichardson.mvc.IMediator;
	import info.simonrichardson.mvc.IView;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import flash.utils.Dictionary;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class View implements IView
	{
		
		protected var _facade : IFacade;
		
		protected var _signalMap : Dictionary;

		protected var _mediatorMap : Dictionary;

		public function View()
		{
		}

		public function initialize(facade : IFacade) : void
		{
			this._facade = facade;
			
			_signalMap = new Dictionary();
			_mediatorMap = new Dictionary();
		}

		public function addHook(hook : IHook) : void
		{
			var signal : Signal;
			
			if (null == _signalMap[hook.name])
			{
				if (null == hook.valueClasses )
				{
					signal = new Signal();
				}
				else
				{
					signal = new Signal(hook.valueClasses);
				}

				_signalMap[hook.name] = signal;
			}

			signal = _signalMap[hook.name];
			signal.add(hook.listener);
		}

		public function removeHook(hook : IHook) : void
		{
			if (null != _signalMap[hook.name])
			{
				const signal : Signal = _signalMap[hook.name];

				signal.remove(hook.listener);

				if (signal.numListeners == 0)
				{
					delete _signalMap[hook.name];
				}
			}
		}

		public function getSignal(signalName : String) : ISignal
		{
			return _signalMap[signalName];
		}

		public function registerMediator(mediator : IMediator) : void
		{
			mediator.initialize(_facade, this);

			_mediatorMap[mediator.name] = mediator;

			const hooks : Vector.<IHook> = mediator.listSignalHooks();

			if (hooks.length != 0)
			{
				var index : int = hooks.length;
				while (--index > -1)
				{
					addHook(hooks[index]);
				}
			}

			mediator.onRegister();
		}

		public function retrieveMediator(mediatorName : String) : IMediator
		{
			return _mediatorMap[ mediatorName ];
		}

		public function removeMediator(mediatorName : String) : IMediator
		{
			var mediator : IMediator = _mediatorMap[ mediatorName ];
			if (null != mediator)
			{
				const hooks : Vector.<IHook> = mediator.listSignalHooks();

				if (hooks.length == 0)
				{
					var index : int = hooks.length;
					while (--index > -1)
					{
						removeHook(hooks[index]);
					}
				}

				delete _mediatorMap[mediatorName];

				mediator.onRemove();
			}

			return mediator;
		}

		public function hasMediator(mediatorName : String) : Boolean
		{
			return _mediatorMap[ mediatorName ] != null;
		}

		public function get name() : String
		{
			return "View";
		}
	}
}
