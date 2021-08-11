function batchLTSA_mk_ltsa_batch(precheck)

global PARAMS REMORA

% load in data from precheck
indirs =    precheck.indirs;
outdirs =   precheck.outdirs;
prefixes =  precheck.prefixes;
outfiles =  precheck.outfiles;
dirdata =   precheck.dirdata;
taves =     precheck.taves;
dfreqs =    precheck.dfreqs;

% loop through each of the sets of directories for actual ltsa creation
for k = 1:length(indirs)
    
    % if we have different parameters for each of the dirs, adjust
    % accordingly
    if length(taves) > 1
        tave = taves(k);
    else
        tave = taves;
    end
    if length(dfreqs) > 1
        dfreq = dfreqs(k);
    else
        dfreq = dfreqs;
    end
    
    PARAMS.ltsa.indir = char(indirs{k});
    PARAMS.ltsa.outdir = char(outdirs{k});
    PARAMS.ltsa.outfile = char(outfiles{k});
    PARAMS.ltsa.tave = tave;
    PARAMS.ltsa.dfreq = dfreq;
    
    %     prefix = prefixes{k};
    
    % run from matlab command line 
    if ~isfield(REMORA, 'hrp') % this *else* isn't tested...carry over from Ann Allen*
        d = dirdata{k};
        if ~isfield(d, 'dataID') % non xwav/typical dir
            fprintf('\nMaking LTSA for directory %s\n', PARAMS.ltsa.indir)
        else
            fprintf('\nMaking LTSA for %s disk %s df %i\n', d.dataID, d.disk, d.df);
        end
        % run from procFun
    else
        % untested...
        fprintf('\nMaking LTSA for %s disk %s df %i\n', REMORA.hrp.dataID, REMORA.hrp.disk, REMORA.hrp.dfs(k));
    end
    
    % make the ltsa!
    batchLTSA_mk_ltsa_dir;
    fprintf('\nFinished LTSA for directory %s\n', PARAMS.ltsa.indir)
    % fprintf('Press any key to continue...\n')
    %     pause
end % all directories

end





