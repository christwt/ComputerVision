% %%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Final Project: reportBuilder.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [report] = reportBuilder(reportPicture, dept, suspectInfo, doctype)
% This function generates the suspect report using the information gathered
% in the generate report function. Uses matlab report generator classes to
% programmatically format the output report document.
% generates a PDF Formatting Object(FO) as well as PDF report
% which is stored in the same directory for PDF styling.

% For more information and documentation of the methods used in this
% function from the MATLAB report generator documentation:
% Programatic report generation:
%   https://www.mathworks.com/help/rptgen/programmatic-report-creation.html
% Create report templates:
%   https://www.mathworks.com/help/rptgen/ug/create-an-html-template.html
% Form based report generation:
%   https://www.mathworks.com/help/rptgen/ug/add-holes-in-an-html-template.html

    % import necessary packages.
    import mlreportgen.dom.*;
    template = 'myPDFtemplate2';

    % Extract information from passed 'answer' cell array
    sName = suspectInfo{1}; % suspect name
    sId = suspectInfo{2};   % suspect ID
    dT = suspectInfo{3};    % date
    iN = suspectInfo{4};    % invesitation number
    iS = suspectInfo{5};    % investigation status
    obs = suspectInfo{6};   % observations
    
    % Extract information from passed 'dept' cell array
    dName = char(dept(1));   % dept name
    dAddr = char(dept(2));   % dept address
    dNum = char(dept(3));    % dept telephone
    dSite = char(dept(4));   % dept website
    
    fprintf('dName: %s\n', dName);
    
    % Create report and title
    report = Document(sprintf('SuspectReport_%s_%s',sId,dT),doctype,template);
    open(report);

    % Create page header
    header = PDFPageHeader('default');
    report.CurrentPageLayout.PageHeaders = header;
    ht = Text('Suspect Report Generator v1.0');
    ht.Style = {FontSize('8pt'),FontFamily('Times'),Underline('single')};
    ht.WhiteSpace = 'preserve';
    pageinfo = Paragraph();
    pageinfo.HAlign = 'right';
    append(pageinfo,ht);
    append(header, pageinfo);
    
    % Create page footer
    footer = PDFPageFooter('default');
    report.CurrentPageLayout.PageFooters = footer;
    report.CurrentPageLayout.FirstPageNumber = 1;
    ft = Text('');
    ft.Style = {FontSize('8pt'),FontFamily('Times')};
    ft.WhiteSpace = 'preserve';
    pageinfo = Paragraph();
    pageinfo.HAlign = 'right';
    append(pageinfo,ft);
    append(pageinfo,Page());
    append(footer,pageinfo);
    
    % Dept Info Fill HTML template with user input.
    deptp = DocumentPart(report, 'Dept Content');
    moveToNextHole(deptp);
    append(deptp, dName);
    moveToNextHole(deptp);
    append(deptp, dAddr);
    moveToNextHole(deptp);
    append(deptp, dNum);
    moveToNextHole(deptp);
    append(deptp, dSite);

    % Add image to report.
    imwrite(reportPicture, 'reportPic.jpg');
    image = Image('reportPic.jpg'); 
    titleinfo = Paragraph();
    titleinfo.HAlign = 'left';
    append(titleinfo, image);
    
    % Suspect Info, fill HTML template with user input
    susp = DocumentPart(report, 'Suspect Info');
    moveToNextHole(susp);
    append(susp, sName);
    moveToNextHole(susp);
    append(susp, sId);
    moveToNextHole(susp);
    append(susp, iN);
    moveToNextHole(susp);
    append(susp, iS);

    % obs
    ob = Paragraph('Initial Observations:');
    ob.Style = {FontSize('13pt'),FontFamily('Times'),Underline('single')};
    ob.HAlign = 'left';

    % obsText
    obText = Paragraph(sprintf('- %s', obs));
    obText.Style = {FontSize('12pt'),FontFamily('Times')};
    obText.HAlign = 'left';

    % Build Report
    append(report, deptp);
    append(report, titleinfo); 
    append(report, susp);
    append(report, ob);
    append(report, obText);

    % close and review report.
    close(report);
    rptview(report.OutputPath);  
end