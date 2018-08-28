################################################################################
#This is an internally genertaed by spyglass for Message Tagging Support
################################################################################


use spyglass;
use SpyGlass;
use SpyGlass::Objects;
spyRebootMsgTagSupport();

spySetMsgTagCount(19,20);
spyCacheTagValuesFromBatch(["pe_crossprobe_tag"]);
spyParseTextMessageTagFile("./Project-2/Regression_Run/spyglass_spysch/sg_msgtag.txt");

spyMessageTagTestBenchmark(3,"./Project-2/Regression_Run/spyglass.vdb");

1;