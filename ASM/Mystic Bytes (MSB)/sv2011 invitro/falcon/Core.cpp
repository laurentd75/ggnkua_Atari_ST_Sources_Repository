//==========================================================================================
//		Core
//==========================================================================================
#include <Core.h>
#include <Config.h>
//==========================================================================================

namespace DemoSys
{
//==========================================================================================

void CoreInterface::init()
{
	CoreImplementation::init();
}

void CoreInterface::shutdown()
{
	CoreImplementation::shutdown();
}

bool CoreInterface::loop()
{
	return CoreImplementation::loop();
}


//==========================================================================================
}