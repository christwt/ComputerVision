import mlreportgen.dom.*;

report = Document('suspect report', 'html');
open(report);

addHTMLFile(report, 'suspectInfo.html');
title = 'Unidentified';
moveToNextHole(report);
append(report, title);



close(report);
rptview(report.OutputPath); 



