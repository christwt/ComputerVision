import mlreportgen.dom.*;

report = Document('suspect report', 'pdf', 'myPDFtemplate2');
open(report);

deptp = DocumentPart(report, 'Dept Content');

moveToNextHole(deptp);
append(deptp,'LuckyStart');
moveToNextHole(deptp);
append(deptp,'FakeAddr');
moveToNextHole(deptp);
append(deptp,'FakeNumber');
moveToNextHole(deptp);
append(deptp,'FakeSite');

image = Image('reportPic.jpg'); 
titleinfo = Paragraph();
titleinfo.HAlign = 'center';
append(titleinfo, image);

susp = DocumentPart(report, 'Suspect Info');
moveToNextHole(susp);
append(susp, '');
moveToNextHole(susp);
append(susp, '');
moveToNextHole(susp);
append(susp, '');
moveToNextHole(susp);
append(susp, '');

append(report, deptp);
append(report, titleinfo);
append(report, susp);

close(report);
rptview(report.OutputPath); 