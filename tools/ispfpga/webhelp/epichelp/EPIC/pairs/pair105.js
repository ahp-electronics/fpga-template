var pairs =
{
"open":{"design":1}
,"design":{"dialog":1,"button":1,"allows":1,"file":1,"(.ncd)":1,"closes":1}
,"dialog":{"box":1}
,"box":{"open":1,"appears":1,"select":1,"cancel":1,"help":1,"opening":1}
,"appears":{"choose":1}
,"choose":{"open":1}
,"button":{"epic":1,"allows":1,"applies":1,"ignores":1}
,"epic":{"start":1,"assumes":1}
,"start":{"dialog":1}
,"select":{"design":1}
,"allows":{"select":1,"navigate":1}
,"file":{"associated":1,"feature":1,"browse":1,"preference":1,"auto":1,"specified":1,"filename":1,"button":1}
,"associated":{"preference":1}
,"preference":{"file":1,"(.prf)":1}
,"feature":{"description":1}
,"description":{"design":1}
,"browse":{"button":1}
,"navigate":{"physical":1}
,"physical":{"design":1,"preference":1}
,"(.ncd)":{"file":1}
,"(.prf)":{"file":1}
,"auto":{"lookup":1}
,"lookup":{"enabled":1}
,"enabled":{"preference":1}
,"specified":{"epic":1,"closes":1}
,"assumes":{"preference":1}
,"filename":{"(but":1}
,"(but":{"different":1}
,"different":{"extension)":1}
,"extension)":{"design":1}
,"applies":{"given":1}
,"given":{"options":1}
,"options":{"current":1,"may":1}
,"current":{"design":1}
,"closes":{"dialog":1}
,"cancel":{"button":1}
,"ignores":{"options":1}
,"may":{"specified":1}
,"help":{"opens":1,"topic":1}
,"opens":{"online":1}
,"online":{"help":1}
,"topic":{"dialog":1}
,"opening":{"designs":1}
,"designs":{"macros":1}
}
;Search.control.loadWordPairs(pairs);
