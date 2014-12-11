global SAMP_FREQ;
global TEST_AOIS;
global WORD_ONSET;
global SMOOTH_PARAM;
global TEST_ENDING;
global FAM_WORDS;
global NEW_WORDS;

global RAW_DATA_DIR;
global AOI_DIR;
global PROCESSED_DATA_DIR;
global DEMO_FILE;

global TEST_WINDOW_START;
global TEST_WINDOW_END;

global FAM_ANSWERS;
global NEW_ANSWERS;
global EASY_TRAINS;
global HARD_TRAINS;
global EASY_TESTS;
global HARD_TESTS;

global X_COL;
global Y_COL;

global PRE_POD_TIME;

global TRIAL_LEN;

SAMP_FREQ = 60;

SMOOTH_PARAM = 80;
TEST_AOIS = {[0 533 300 700],[1067 1800 300 700]};
WORD_ONSET = 179.4;

TEST_ENDING = '.jpg';
FAM_WORDS = {'ball','cat','bird','botle','carrot','lamp','cookie',...
    'baby','dog','book','horse','clock','sheep','hammer','table','lion'};
NEW_WORDS = {'wug','fep','dax','dofa','pifo','kreeb','modi','toma'};

RAW_DATA_DIR = 'raw_data/tab_comp/';
PROCESSED_DATA_DIR = 'processed_data/tab_comp/';
AOI_DIR = [PROCESSED_DATA_DIR '/AOIs/'];
DEMO_FILE = [RAW_DATA_DIR 'demo_data/demos.txt'];



FAM_ANSWERS = [1, 2, 2, 1, 2, 2, 1, 1]';
NEW_ANSWERS = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 1]';

EASY_TESTS = [1, 4, 5];
HARD_TESTS = [2, 3, 6];
%EASY_TESTS = [1, 4, 5, 8, 10, 12];
%HARD_TESTS = [2, 3, 6, 7, 9, 11];

EASY_TRAINS = [1,4,5];
HARD_TRAINS = [2,3,6];

%EASY_TRAINS = [1,4,5,8];
%HARD_TRAINS = [2,3,6,7];
X_COL = 2;
Y_COL = 3;

PRE_POD_TIME = 120;

TRIAL_LEN = 7500;


%DROP_KIDS = [6 23 27 28 35 38 44 50 51 53 54 55 58 91]; %bad calib

