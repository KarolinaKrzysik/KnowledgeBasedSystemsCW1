/*-----------------------------------------------------------------------------------*/
/* CO652 Knowledge Based Systems in Artificial Intellignece -------------------------*/
/* Expert System developed by Karolina Krzysik- 21904889 and Priyam Mantri- 21818266 */
/* Suggest song based on personality type and mood ----------------------------------*/
/*-----------------------------------------------------------------------------------*/

suggest_song:-
	start,
	collect_personality.
	%collect_mood.
	
/*-----------------------------------------------------------------------------------*/
/* User interface Initiate System----------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
start:-
	nl,nl,nl,nl,
	write('------------------------------------------'),nl,
	write('------- SONG RECOMMENDATION SYSTEM -------'),nl,
	write('------------------------------------------'),nl,nl,
	write('Please answer the following questions'),nl,nl,
	write('You MUST use ONLY ONE of the given options'),nl,
	write('Spell correctly, end phrase with full stop and click enter'),nl,nl,nl,nl.
	
	
/*-----------------------------------------------------------------------------------*/
/* Ask user about personality type---------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
	
collect_personality:-
	write('What is your personality type?: '),nl,nl,
	getCorrectInput(Personality),nl,
	(Personality='intj';Personality='intp';Personality='entj';Personality='entp';
	Personality='infj';Personality='infp';Personality='enfj';Personality='enfp';
	Personality='istj';Personality='isfj';Personality='estj';Personality='esfj';
	Personality='istp';Personality='isfp';Personality='estp';Personality='esfp'),
	assertz(personality(Personality));
	(Personality='help'),
	giveSupportQuestionsBroad(Question),
	write(Question),nl,nl,
	getCorrectOption(OneOfFour),nl,
	assertz(oneOfFour(OneOfFour)),
	fail.
	
collect_personality.
/*-----------------------------------------------------------------------------------*/
/* Ensure user typed existed personality type or asks for help ----------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectInput(X):-
	repeat,
	write('Please choose from following options:'),nl,
	write('Analysts: intj, intp, entj, entp'),nl,
	write('Diplomats: infj, infp, enfj, enfp'),nl,
	write('Sentinels: istj, isfj, estj, esfj'),nl,
	write('Explorers: istp, isfp, estp, esfp'),nl,nl,
	write('If you do not know your personality type, type help'),nl,nl,nl,nl,
	read(Z),nl,
	check(Z),
	X=Z,!.				
	
	
/*Analysts*/
check('intj').
check('intp').
check('entj').
check('entp').
/*Diplomats*/
check('infj').
check('infp').
check('enfj').
check('enfp').
/*Sentinels*/
check('istj').
check('isfj').
check('estj').
check('esfj').
/*Explorers*/
check('istp').
check('isfp').
check('estp').
check('esfp').
/*Help*/
check('help').

/*-----------------------------------------------------------------------------------*/
/* Ensure user typed one of the two letters -----------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectOption(X):-
	repeat,
	write('Type one or two'),nl,
	read(Z),nl,
	checkOption(Z),
	X=Z,!.
	
checkOption('one').
checkOption('two').

/*-----------------------------------------------------------------------------------*/
/* 4 questions about characteristics forming personality type -----------------------*/
/*-----------------------------------------------------------------------------------*/

giveSupportQuestionsBroad('Are you Introvert=> one or Extrovert=> two?: ').
giveSupportQuestionsBroad('Are you Intuitive=> one or Observant=> two?: ').
giveSupportQuestionsBroad('Are you Thinking=> one or Feeling=> two?: ').
giveSupportQuestionsBroad('Are you Judging=> one or Prospecting=> two?: ').