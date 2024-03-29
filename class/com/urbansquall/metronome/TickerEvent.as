﻿package com.urbansquall.metronome
{
import flash.events.*;

public class TickerEvent extends Event
{
	public static const TICK : String = "tick";

	private var m_interval : Number;
	
	function TickerEvent( a_interval : Number )
	{
		super( TICK, false, false );
		m_interval = a_interval;
	}
	
	public function get interval() : Number { return m_interval; }
}
}