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
	 * @author Simon Richardson - <simon@ustwo.co.uk>
	 */
	public class View implements IView
	{
		
		protected var facade : IFacade;
		
		protected var signalMap : Dictionary;

		protected var mediatorMap : Dictionary;

		public function View()
		{
		}

		public function initialize(facade : IFacade) : void
		{
			this.facade = facade;
			
			signalMap = new Dictionary(true);
			mediatorMap = new Dictionary(true);
		}

		public function addHook(hook : IHook) : void
		{
			var signal : Signal;

			if (null == signalMap[hook.name])
			{
				if (null == hook.valueClasses )
				{
					signal = new Signal();
				}
				else
				{
					signal = new Signal(hook.valueClasses);
				}

				signalMap[hook.name] = signal;
			}

			signal = signalMap[hook.name];
			signal.add(hook.listener);
		}

		public function removeHook(hook : IHook) : void
		{
			if (null != signalMap[hook.name])
			{
				const signal : Signal = signalMap[hook.name];

				signal.remove(hook.listener);

				if (signal.numListeners == 0)
				{
					delete signalMap[hook.name];
				}
			}
		}

		public function getSignal(signalName : String) : ISignal
		{
			return signalMap[signalName];
		}

		public function registerMediator(mediator : IMediator) : void
		{
			mediator.initialize(facade, this);

			mediatorMap[mediator.name] = mediator;

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
			return mediatorMap[ mediatorName ];
		}

		public function removeMediator(mediatorName : String) : IMediator
		{
			var mediator : IMediator = mediatorMap[ mediatorName ];
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

				delete mediatorMap[mediatorName];

				mediator.onRemove();
			}

			return mediator;
		}

		public function hasMediator(mediatorName : String) : Boolean
		{
			return mediatorMap[ mediatorName ] != null;
		}

		public function get name() : String
		{
			return "View";
		}
	}
}
