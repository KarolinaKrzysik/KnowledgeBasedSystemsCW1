/*-----------------------------------------------------------------------------------*/
/* CO652 Knowledge Based Systems in Artificial Intellignece -------------------------*/
/* Expert System developed by Karolina Krzysik- 21904889 and Priyam Mantri- 21818266 */
/* Suggest song based on personality type and mood ----------------------------------*/
/*-----------------------------------------------------------------------------------*/

suggest_song:-
	start,
	collect_personality,
	collect_preferred_genre,
	collect_mood,
	showSong.
	
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
	giveHelp.
	
	

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
/* Help determine personality type --------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

giveHelp:-
	giveSupportQuestionsBroad1(Question1),
	write(Question1),nl,nl,
	getCorrectOptionIntrovertExtrovert(OneOfFour),nl,
	assertz(oneOfFour(OneOfFour)),
	giveSupportQuestionsBroad2(Question2),
	write(Question2),nl,nl,
	getCorrectOptionIntuitiveObservant(SecondOfFour),nl,
	assertz(oneOfFour(SecondOfFour)),
	giveSupportQuestionsBroad3(Question3),
	write(Question3),nl,nl,
	getCorrectOptionThinkingFeeling(ThirdOfFour),nl,
	assertz(oneOfFour(ThirdOfFour)),
	giveSupportQuestionsBroad4(Question4),
	write(Question4),nl,nl,
	getCorrectOptionJudgingProspecting(FourthOfFour),nl,
	assertz(oneOfFour(FourthOfFour)),
	personalityType(Number,PersonalityCode,Information,Genre1,Genre2,Genre3),nl,nl,
	write(Information),
	assertz(personality(PersonalityCode)).

/*-----------------------------------------------------------------------------------*/
/* Ensure user chose introvert i or extrovert e -------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectOptionIntrovertExtrovert(X):-
	repeat,
	write('Type i or e'),nl,
	read(Z),nl,
	checkOptionIntrovertExtrovert(Z),
	X=Z,!.
	
checkOptionIntrovertExtrovert('i').
checkOptionIntrovertExtrovert('e').

/*-----------------------------------------------------------------------------------*/
/* Ensure user chose intuitive n or observant s -------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectOptionIntuitiveObservant(X):-
	repeat,
	write('Type n or s'),nl,
	read(Z),nl,
	checkOptionIntuitiveObservant(Z),
	X=Z,!.
	
checkOptionIntuitiveObservant('n').
checkOptionIntuitiveObservant('s').

/*-----------------------------------------------------------------------------------*/
/* Ensure user chose thinking t or feeling f ----------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectOptionThinkingFeeling(X):-
	repeat,
	write('Type t or f'),nl,
	read(Z),nl,
	checkOptionThinkingFeeling(Z),
	X=Z,!.
	
checkOptionThinkingFeeling('t').
checkOptionThinkingFeeling('f').

/*-----------------------------------------------------------------------------------*/
/* Ensure user chose judging j or prospecting p -------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectOptionJudgingProspecting(X):-
	repeat,
	write('Type j or p'),nl,
	read(Z),nl,
	checkOptionJudgingProspecting(Z),
	X=Z,!.
	
checkOptionJudgingProspecting('j').
checkOptionJudgingProspecting('p').

/*-----------------------------------------------------------------------------------*/
/* 4 questions about characteristics forming personality type -----------------------*/
/*-----------------------------------------------------------------------------------*/

giveSupportQuestionsBroad1('Are you Introvert => i or Extrovert => e?: ').
giveSupportQuestionsBroad2('Are you Intuitive => n or Observant => s?: ').
giveSupportQuestionsBroad3('Are you Thinking => t or Feeling => f?: ').
giveSupportQuestionsBroad4('Are you Judging => j or Prospecting => p?: ').

/*-----------------------------------------------------------------------------------*/
/* Determine personality type based on 4 responses to questions ---------------------*/
/*-----------------------------------------------------------------------------------*/

personalityType(1, intj, 'Your personality type: architect, intj.','electronic','classical','metal'):-
	oneOfFour(i),oneOfFour(n),oneOfFour(t),oneOfFour(j).
personalityType(2, intp, 'Your personality type: logician, intp.','rock, classical, metal'):-
	oneOfFour(i),oneOfFour(n),oneOfFour(t),oneOfFour(p).
personalityType(3, entj, 'Your personality type: commander, entj.','rock, alternative, indie'):-
	oneOfFour(e),oneOfFour(n),oneOfFour(t),oneOfFour(j).
personalityType(4, entp, 'Your personality type: debater, entp.','rock, blues, indie'):-
	oneOfFour(e),oneOfFour(n),oneOfFour(t),oneOfFour(p).
personalityType(5, infj, 'Your personality type: advocate, infj.','indie_rock, classical, folk'):-
	oneOfFour(i),oneOfFour(n),oneOfFour(f),oneOfFour(j).
personalityType(6, infp, 'Your personality type: mediator, infp.','rock, metal, folk'):-
	oneOfFour(i),oneOfFour(n),oneOfFour(f),oneOfFour(p).
personalityType(7, enfj, 'Your personality type: protagonist, enfj.','world, inde, alternative'):-
	oneOfFour(e),oneOfFour(n),oneOfFour(f),oneOfFour(j).
personalityType(8, enfp, 'Your personality type: campaigner, enfp.','rock, alternative, pop'):-
	oneOfFour(e),oneOfFour(n),oneOfFour(f),oneOfFour(p).
personalityType(9, istj, 'Your personality type: logistician, istj.','rock, alternative, pop'):-
	oneOfFour(i),oneOfFour(s),oneOfFour(t),oneOfFour(j).
personalityType(10, isfj, 'Your personality type: defender, isfj.','soft_rock, alternative, indie'):-
	oneOfFour(i),oneOfFour(s),oneOfFour(f),oneOfFour(j).
personalityType(11, estj, 'Your personality type: executive, estj.', 'rock, electronic, pop'):-
	oneOfFour(e),oneOfFour(s),oneOfFour(t),oneOfFour(j).
personalityType(12, esfj, 'Your personality type: consul, esfj.','musicals, pop, country'):-
	oneOfFour(e),oneOfFour(s),oneOfFour(f),oneOfFour(j).
personalityType(13, istp, 'Your personality type: virtuoso, istp.','classic_rock, metal, alternative'):-
	oneOfFour(i),oneOfFour(s),oneOfFour(t),oneOfFour(p).
personalityType(14, isfp, 'Your personality type: adventurer, isfp.','rock, classical, alternative'):-
	oneOfFour(i),oneOfFour(s),oneOfFour(f),oneOfFour(p).
personalityType(15, estp, 'Your personality type: entrepreneur, estp.','hip_hop, electronic, rap'):-
	oneOfFour(e),oneOfFour(s),oneOfFour(t),oneOfFour(p).
personalityType(16, esfp, 'Your personality type: entertainer, esfp.','alternative, rock, rap'):-
	oneOfFour(e),oneOfFour(s),oneOfFour(f),oneOfFour(p).
	
	
/*-----------------------------------------------------------------------------------*/
/* Ask user about mood---------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

collect_mood:-
	nl,
	write('What is your current mood, good or bad?: '),nl,nl,
	getCorrectMood(Mood),nl,
	assertz(mood(Mood)).
	
/*-----------------------------------------------------------------------------------*/
/* Ensure user types good or bad mood -------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectMood(X):-
	repeat,
	write('Type good or bad'),nl,
	read(Z),nl,
	checkMood(Z),
	X=Z,!.
	
checkMood('good').
checkMood('bad').

/*-----------------------------------------------------------------------------------*/
/* Collect genre preferation --------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

collect_preferred_genre:-
	personalityType(Number,Personality,Information,Genre1,Genre2,Genre3),nl,nl,
	write('Recommended genres for your personality type:'),nl,
	write(Genre1),nl,
	write(Genre2),nl,
	write(Genre3),nl,nl,
	write('If you have a preference of the given 3 genres, type name of it'),nl,
	write('If you prefer to get a surprise, type: any'),nl,nl,
	getAllowedGenre(GenrePreferation),
	(GenrePreferation='any'),
	assertz(genrePreferation(Genre1));
	assertz(genrePreferation(GenrePreferation)).
	
	
	
	

/*-----------------------------------------------------------------------------------*/
/* Check user types one of the allowed genres Architect -----------------------------*/
/*-----------------------------------------------------------------------------------*/

getAllowedGenre(X):-
	repeat,
	write('Type ONE from the given genres or any'),nl,
	read(Z),nl,
	checkGenre(Z),
	X=Z,!.
	
checkGenre('electronic').
checkGenre('classical').
checkGenre('metal').
checkGenre('any').






/*-----------------------------------------------------------------------------------*/
/* Songs ----------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

song(1,'Riton, RAYE - I Dont Want You','https://www.youtube.com/watch?v=Bkwy6OD55Xo'):-
	genrePreferation(electronic), mood(good).

showSong:-
	nl,nl,nl,
	write('Your song recommendation: '),nl,
	song(Number,Title,Url),
	write(Title),nl,
	write(Url),nl.