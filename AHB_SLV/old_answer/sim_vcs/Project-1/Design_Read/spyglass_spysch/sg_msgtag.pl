################################################################################
#This is an internally genertaed by spyglass for Message Tagging Support
################################################################################


use spyglass;
use SpyGlass;
use SpyGlass::Objects;
spyRebootMsgTagSupport();

spySetMsgTagCount(0,13);
spyParseTextMessageTagFile("./Project-1/Design_Read/spyglass_spysch/sg_msgtag.txt");

spyMessageTagTestBenchmark(2,"./Project-1/Design_Read/spyglass.vdb");

1;