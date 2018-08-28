################################################################################
#This is an internally genertaed by spyglass for Message Tagging Support
################################################################################


use spyglass;
use SpyGlass;
use SpyGlass::Objects;
spyRebootMsgTagSupport();

spySetMsgTagCount(0,13);
spyParseTextMessageTagFile("./Project-1/initial_rtl/lint/synthesis/spyglass_spysch/sg_msgtag.txt");

spyMessageTagTestBenchmark(4,"Project-1/initial_rtl/lint/synthesis/spyglass.vdb");

1;