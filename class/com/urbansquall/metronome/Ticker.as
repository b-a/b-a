﻿package com.urbansquall.metronome
{

import flash.display.*;
import flash.events.*;
import flash.utils.*;

// Ticker is almost indentical to the built in Timer class.
// Minus the suck.

public class Ticker extends EventDispatcher
{
	private var m_timeOfLastUpdate : Number;
	private var m_delay : Number;
	private var m_running : Boolean;
	private var m_accruedTime : Number;
	private var m_shape : Shape; // To give us an ENTER_FRAME hook
	
	public function Ticker( a_delay : Number = 33 )
	{
		m_running = false;

		m_delay = a_delay;
				
		m_shape = new Shape();
	}
	
	public function start() : void
	{
		m_running = true;
		m_timeOfLastUpdate = getTimer();
		m_accruedTime = 0;
		m_shape.addEventListener( Event.ENTER_FRAME, tick, false, 0, true );
	}
	
	public function stop() : void
	{
		m_shape.removeEventListener( Event.ENTER_FRAME, tick );
		m_running = false;
	}
		
	public function get delay() : int { return m_delay; }
	
	public function get running(): Boolean { return m_running; }
	
	private function tick( a_event : Event ) : void
	{
		var deltaTime : Number = calculateDeltaTime();
		
		if( !m_running ) return;
				
		m_accruedTime += deltaTime;
				
		while( m_accruedTime >= m_delay )
		{
			m_accruedTime -= m_delay;
			
			dispatchEvent( new TickerEvent( m_delay ) );
		}
	}
	
	private function calculateDeltaTime() : Number
	{
		var currentTime : Number = getTimer();
		var deltaTime : Number = currentTime - m_timeOfLastUpdate;
		m_timeOfLastUpdate = currentTime;
		return deltaTime;
	}
}
}