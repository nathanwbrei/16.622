% % % % % % % % % %% % % % % % % % % % % % % % %
% Autogenerate a viewgraph and table depicting
% the results of an experiment with Spider.
% Generates TikZ inside LaTeX inside MATLAB. Fun!
%
% by Nathan Brei
% n_brei@mit.edu
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
% % % % % % % % % %% % % % % % % % % % % % % % %
%
% function visualize (results, labels, fname, titletext, silent)
%
% Inputs:  results    Matrix output of results.m
%          labels     Cell array of strings corresponding to SVM classes
%          fname      String for filename of LaTeX/TikZ source output
%          titletext  String for figure title
%          [silent]   Verbose pdflatex output? [Default=1]

function visualize (results, labels, fname, titletext, silent)
if(nargin==4), silent=1; end;

% get percentages 
colsum = sum(results,1);
probs = results;
for n=1:size(results,2)
    probs(:,n) = probs(:,n) / colsum(n);
end

% Generate data string for LaTeX viewgraph, along with results table
fignum=['\\def \\nbclasses {' int2str(length(results)),'}\n'];
figdata='\\def \\nbviewgraphdata {';
for p=1:length(results)
    for q=1:length(results)
        percent = round(probs(p,q)*100);
        figdata = strcat(figdata, num2str(percent,3),'/',...
            num2str(sqrt(probs(p,q))),'/',int2str(q-1),'/',...
            int2str(p-1),'/',int2str(results(p,q)),'/', ...
            int2str(sum(results(:,q))),',');    
    end
end
figdata = strcat(figdata(1:end-1), '}\n');


% Generate labels string for LaTeX viewgraph
figlabels='\\def \\nbviewgraphlabels {';
for m=1:length(labels) 
    figlabels = strcat(figlabels, char(labels(m)), '/', int2str(m-1),',');
end
figlabels = strcat(figlabels(1:end-1), '}\n');

figtitle=['\\def \\titletext {' titletext '}\n'];

% LaTeX source for stub, so we can compile figure
stubtext={
'\\documentclass{article}'
'\\usepackage{tikz}'
'\\usepackage{fullpage}'
'\\usepackage{booktabs}'
'\\begin{document}'
'\\begin{center}'
'\\input{test.tex}'
'\\end{center}'
'\\end{document}'
};


% LaTeX source for viewgraph
figtext={ ...
'\\begin{tikzpicture}'
'   [scale=1.5, anno/.style={draw=none,fill=none,font=\\tiny},'
'   head/.style={draw=none,fill=none,font=\\footnotesize},'
'   title/.style={draw=none,fill=none,font=\\large},'
'   bubble/.style={draw=black!30, inner sep=0pt, fill=black!10, circle}]{'
'\\draw[step=1cm, black!20, thin] (-.7,-.7) grid (\\nbclasses-.3,\\nbclasses-.3);'
'\\draw[black,thick] (-.6,-.6) rectangle (\\nbclasses-.3,\\nbclasses-.3);'
''
'\\node[title] at (\\nbclasses/2-0.5, \\nbclasses+.5) {\\titletext};'
'\\node[head] at (\\nbclasses/2-0.5, \\nbclasses-.1) {$\\longleftarrow$\\ Actual Barriers\\ $\\longrightarrow$};'
'\\node[head, rotate=90] at (\\nbclasses-.1, \\nbclasses/2-0.5) {$\\longleftarrow$\\ Predicted Barriers\\ $\\longrightarrow$};'
''
'\\foreach \\bar / \\iter in \\nbviewgraphlabels {'
'   \\node[head] at (\\iter,-.8) {\\bar};'
'   \\node[head,rotate=90] at (-.8, \\iter) {\\bar}; }'
''
'\\foreach \\pct / \\rad / \\x / \\y / \\num / \\tot in \\nbviewgraphdata {'
'   \\node[bubble, minimum size=1.5*\\rad cm] at (\\x,\\y) {};'
'   \\node[anno] at (\\x,\\y+.075) {\\pct\\%%};'
'   \\node[anno] at (\\x,\\y-.075) {\\num/\\tot};}'
'};'
'\\end{tikzpicture}' ...
};

% Assemble LaTeX stub
if ~exist('visuals','dir')
	mkdir visuals
end
fid=fopen(['visuals/stub' fname],'w');
stubtext(7)=cellstr(['\\input{' fname '}']);
for w=1:length(stubtext)
    fprintf(fid,[char(stubtext(w)) '\n']);
end

% Assemble viewgraph figure
fclose(fid);
fid = fopen(['visuals/' fname], 'w');
fprintf(fid,fignum);
fprintf(fid,figdata);
fprintf(fid,figlabels);
fprintf(fid,figtitle);
for w=1:length(figtext)
    fprintf(fid,[char(figtext(w)) '\n']);
end
fclose(fid);

% Compile and show
if silent
    system(['cd visuals; /usr/texbin/pdflatex stub' fname ' >silent.txt']);
    system(['open visuals/stub' fname(1:end-4) '.pdf']);
else
    system(['cd visuals; /usr/texbin/pdflatex stub' fname]);
    system(['open visuals/stub' fname(1:end-4) '.pdf']);
end 
