% %%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Final Project: reportPDF.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [report] = reportBuilder(reportPicture, sName, sId, dT, iS, obs, doctype)
% This function generates the suspect report using the information gathered
% in the generate report function. Uses matlab report generator classes to
% programmatically format the output PDF.

    % import necessary packages.
    import mlreportgen.dom.*;

    if strcmp(doctype,'pdf')
        % Create and Title Report
        report = Document(sprintf('SuspectReport_%s',sId),doctype);
        open(report);

        % Create page header
        header = PDFPageHeader('default');
        report.CurrentPageLayout.PageHeaders = header;
        ht = Text('Suspect Report Generator v1.0');
        ht.Style = {FontSize('16pt'),FontFamily('Times'),Underline('single')};
        ht.WhiteSpace = 'preserve';
        pageinfo = Paragraph();
        pageinfo.HAlign = 'center';
        append(pageinfo,ht);
        append(header, pageinfo);

         %Create page footer
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

        % Add image to report.
        icon = imread('lawEnforceIcon.jpg');
        image = Image('lawEnforceIcon.jpg');
        image.Style = {Height('300px'),Width('300px')}; 
        titleinfo = Paragraph();
        titleinfo.HAlign = 'center';
        append(titleinfo, image);

        % Title of the form: sId (date)
        ident = Text(sprintf('Suspect ID: %s (%s)',sId, dT));
        ident.Style = {FontSize('14pt'),FontFamily('Times')};
        identinfo = Paragraph();
        identinfo.HAlign = 'center';
        append(identinfo, ident);

        newln = Paragraph(' ');
        newln.Style = {FontSize('56pt')};

        % sName
        name = Paragraph('Suspect Name:');
        name.Style = {FontSize('16pt'),FontFamily('Times'),Underline('single')};
        name.HAlign = 'center';

        % sNameText
        nameText = Paragraph(sprintf('- %s',sName));
        nameText.Style = {FontSize('14pt'),FontFamily('Times')};
        nameText.HAlign = 'center';

        % sId
        id = Paragraph('Suspect ID:');
        id.Style = {FontSize('16pt'),FontFamily('Times'),Underline('single')};
        id.HAlign = 'center';

        % sId Text
        idText = Paragraph(sprintf('- %s',sId));
        idText.Style = {FontSize('14pt'),FontFamily('Times')};
        idText.HAlign = 'center';

        % iS
        is = Paragraph('Investigation Status:');
        is.Style = {FontSize('16pt'),FontFamily('Times'),Underline('single')};
        is.HAlign = 'center';

        % iSText
        iSText = Paragraph(sprintf('- %s', iS));
        iSText.Style = {FontSize('14pt'),FontFamily('Times')};
        iSText.HAlign = 'center';

        % obs
        ob = Paragraph('Initial Observations:');
        ob.Style = {FontSize('16pt'),FontFamily('Times'),Underline('single')};
        ob.HAlign = 'center';

        % obsText
        obText = Paragraph(sprintf('- %s', obs));
        obText.Style = {FontSize('14pt'),FontFamily('Times')};
        obText.HAlign = 'center';

        % Build Report
        % append(report, newln);
        append(report, titleinfo);  
        append(report, identinfo);
        append(report, name);
        append(report, nameText);
        append(report, id);
        append(report, idText);
        append(report, is);
        append(report, iSText);
        append(report, ob);
        append(report, obText);

    end
    % to be able to close and view report
    close(report);
    rptview(report.OutputPath);
    
    
end