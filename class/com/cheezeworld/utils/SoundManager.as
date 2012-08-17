package com.cheezeworld.utils
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	
	public class SoundManager
	{
				
		// -- INITIALIZATION ---
	 	public static function get instance():SoundManager
		{
	 		if(SoundManager.m_instance == null)
	 		{
	 			SoundManager.m_instance = new SoundManager(new SingletonEnforcer());
	 		}
	 		return SoundManager.m_instance;
	 	}
	 	
	 	private static var m_instance:SoundManager;
	 	// ----------------------
	 	
	 	public function get soundVolume():Number{ return m_soundTransform.volume; }
	 	public function set soundVolume( volume:Number ) : void
	 	{ 
	 		if( volume < 0 )
			{
				volume = 0;
			}
	 		m_soundTransform.volume = volume; 
	 	}
		public function get musicVolume():Number{ return m_musicTransform.volume; }
		public function set musicVolume( volume:Number ) : void
		{
			if( volume < 0 )
			{
				volume = 0;
			}
			m_musicTransform.volume = volume;
			m_musicChannel.soundTransform = m_musicTransform;
		}
		
	 	public function SoundManager( enforcer:SingletonEnforcer )
		{
			m_musicChannel = new SoundChannel();
			m_musicTransform = new SoundTransform( 1 );
			m_soundTransform = new SoundTransform( 1 );
			m_sounds = new Dictionary();
			m_channels = new Dictionary();
		}
		
		public function registerSound( a_sound:Sound, a_id:String ) : void
		{
			m_sounds[ a_id ] = a_sound;
		}
		
		public function playSound( a_id:String, a_startTime:int = 0, a_loops:int = 0 ) : void
		{			
			if( m_sounds[ a_id ] == null )
			{
				throw new Error( "<SoundManager> Sound: " + a_id + " does not exist!" );		
			}
			else
			{
				m_channels[ a_id ] = m_sounds[ a_id ].play( a_startTime, a_loops, m_soundTransform );
			}
		}
		
		public function stopSound( a_id:String ) : void
		{
			if( m_channels[ a_id ] != null )
			{
				m_channels[ a_id ].stop();
				delete m_channels[ a_id ];
			}
		}
		
		public function playMusic( a_id:String, a_start:int = 0, a_loops:int=0 ) : void
		{
			if( m_sounds[ a_id ] == null )
			{
				throw new Error( "<SoundManager> Sound: " + a_id + " does not exist!" );		
			}
			m_musicChannel = m_sounds[ a_id ].play( a_start, a_loops, m_musicTransform );
		}
		
		public function stopMusic() : void
		{
			m_musicChannel.stop();
		}
		
		private var m_sounds:Dictionary;
		private var m_channels:Dictionary;
		private var m_musicChannel:SoundChannel;
		private var m_musicTransform:SoundTransform;
		private var m_soundTransform:SoundTransform;
	
	}
}

class SingletonEnforcer{}