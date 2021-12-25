/*-----------------------------------------------------------------------------------*/
/* CO652 Knowledge Based Systems in Artificial Intellignece -------------------------*/
/* Expert System developed by Karolina Krzysik- 21904889 and Priyam Mantri- 21818266 */
/* Suggest song based on personality type and mood ----------------------------------*/
/*-----------------------------------------------------------------------------------*/

:- dynamic(personality/1).
:- dynamic(genrePreferation/1).
:- dynamic(introvert/1).
:- dynamic(extrovert/1).
:- dynamic(intuitive/1).
:- dynamic(observant/1).
:- dynamic(thinking/1).
:- dynamic(feeling/1).
:- dynamic(judging/1).
:- dynamic(prospecting/1).
introvert(a).
extrovert(a).
intuitive(a).
observant(a).
thinking(a).
feeling(a).
judging(a).
prospecting(a).

suggest_song:-

	retractall(personality(_)),
	retractall(genrePreferation(_)),
	retractall(mood(_)),
	retractall(oneOfFour(_)),
	retractall(introvert(_)),
	retractall(extrovert(_)),
	retractall(intuitive(_)),
	retractall(observant(_)),
	retractall(feeling(_)),
	retractall(thinking(_)),
	retractall(judging(_)),
	retractall(prospecting(_)),
	start,
	write('What is your personality type code?: '),nl,nl,
	collect_personality,
	personalityAndGenres(No,Code,G1,G2,G3),
	nl,nl,nl,nl,
	write('Recommended genres for '),write(Code),write(' personality type: '),nl,
	write(G1),nl,
	write(G2),nl,
	write(G3),nl,nl,
	write('Choose from the 3 above options for a song tailored to your personality type'),nl,
	write('UNLESS happy about the 3 genres, type your own genre'),nl,nl,nl,nl,
	collect_preferred_genre,nl,
	write('What is your current mood, good or bad?: '),nl,nl,
	collect_mood,
	showSong,
	/*Clean database for next usage of system*/
	retractall(personality(_)),
	retractall(genrePreferation(_)),
	retractall(mood(_)),
	retractall(oneOfFour(_)),
	retractall(introvert(_)),
	retractall(extrovert(_)),
	retractall(intuitive(_)),
	retractall(observant(_)),
	retractall(feeling(_)),
	retractall(thinking(_)),
	retractall(judging(_)),
	retractall(prospecting(_)).
	
	
/*-----------------------------------------------------------------------------------*/
/* User interface Initiate System----------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
start:-
	nl,nl,nl,nl,
	write('------------------------------------------------------------'),nl,
	write('---------------- SONG RECOMMENDATION SYSTEM ----------------'),nl,
	write('------------------------------------------------------------'),nl,nl,
	write('Please answer the following questions'),nl,nl,
	write('You MUST use ONLY ONE of the given options'),nl,
	write('Spell correctly, end phrase with full stop and click enter'),nl,nl,
	
	write('Type why to find out how question is relevant for suggesting a song for your personality'),nl,
	write('Type how to discover why particular song was recommended'),nl,
	write('You can ask why or how whenever you see =>why or =>how phrase respectively under question'),nl,nl,nl,nl,nl.
	
	
/*-----------------------------------------------------------------------------------*/
/* Ask user about personality type---------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
	
collect_personality:-
	
	getCorrectInput(Personality),nl,
	(((Personality='why'),
	write('.................................................................................................'),nl,nl,
	write('Personality type code indicates personality type you have.'),nl,
	write('Personality type along with mood are essential factors shaping song recommendation.'),nl,
	write('Certain personality types prefer certain music genres to other genres based on statistical data.'),nl,
	write('.................................................................................................'),
	nl,nl,
	collect_personality);
	
	(Personality='intj';Personality='intp';Personality='entj';Personality='entp';
	Personality='infj';Personality='infp';Personality='enfj';Personality='enfp';
	Personality='istj';Personality='isfj';Personality='estj';Personality='esfj';
	Personality='istp';Personality='isfp';Personality='estp';Personality='esfp'),
	assertz(personality(Personality));
	
	((Personality='help'),
	giveHelp)).
	



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
	write('If you do not know your personality type code, type help'),nl,
	write('=>why'),nl,nl,nl,nl,
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
/*Why*/
check('why').

/*-----------------------------------------------------------------------------------*/
/* Help determine personality type --------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

giveHelp:-
	giveSupportQuestionsBroad1(Question1),
	write(Question1),nl,nl,
	checkout1,
	giveSupportQuestionsBroad2(Question2),
	write(Question2),nl,nl,
	checkout2,
	giveSupportQuestionsBroad3(Question3),
	write(Question3),nl,nl,
	checkout3,
	giveSupportQuestionsBroad4(Question4),
	write(Question4),nl,nl,
	checkout4,
	
	personalityType(Number,PersonalityCode,Information),nl,nl,
	write(Information),
	assertz(personality(PersonalityCode)).

/*-----------------------------------------------------------------------------------*/
/* Help Introvert Extrovert ---------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

checkout1:-
	getCorrectOptionIntrovertExtrovert(OneOfFour),nl,
	
	(((OneOfFour='why'),
	write('.................................................................................................'),nl,nl,
	write('Personality type consists of 4 main characteristics.'),nl,
	write('Introvert or Extrovert defines the first characteristic.'),nl,
	write('Personality type along with mood are essential factors shaping song recommendation.'),nl,
	write('.................................................................................................'),
	nl,nl,
	checkout1);
	
	(OneOfFour='i';OneOfFour='e'),
	assertz(oneOfFour(OneOfFour));
	(OneOfFour='test1'),
	write('This test is to determine whether you are an Introvert or Extrovert.'),nl,nl,
	write('Respond to statements'),nl,
	write('If statement is 0-49% true => answer f, if its 50-100% true => answer t'),nl,nl,nl,nl,
	
	test1,
	checkIfIntrovert(Char, Display),nl,
	write(Display),nl,nl,
	assertz(oneOfFour(Char))).
	
/*-----------------------------------------------------------------------------------*/
/* Help Intuitive Observant ---------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
checkout2:-
	getCorrectOptionIntuitiveObservant(SecondOfFour),nl,
	
	(((SecondOfFour='why'),
	write('.................................................................................................'),nl,nl,
	write('Personality type consists of 4 main characteristics.'),nl,
	write('Intuitive or Observant defines the second characteristic.'),nl,
	write('Personality type along with mood are essential factors shaping song recommendation.'),nl,
	write('.................................................................................................'),
	nl,nl,
	checkout2);
	
	
	(SecondOfFour='n';SecondOfFour='s'),
	assertz(oneOfFour(SecondOfFour));
	(SecondOfFour='test2'),
	write('This test is to determine whether you are an Intuitive or Observant.'),nl,nl,
	write('Respond to statements'),nl,
	write('If statement is 0-49% true => answer f, if its 50-100% true => answer t'),nl,nl,nl,nl,
	test2,
	checkIfIntuitive(Char2, Display2),nl,
	write(Display2),nl,nl,
	assertz(oneOfFour(Char2))).
	
/*-----------------------------------------------------------------------------------*/
/* Help Thinking Feeling ------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

checkout3:-
	getCorrectOptionThinkingFeeling(ThirdOfFour),nl,
	
	(((ThirdOfFour='why'),
	write('.................................................................................................'),nl,nl,
	write('Personality type consists of 4 main characteristics.'),nl,
	write('Thinking or Feeling defines the third characteristic.'),nl,
	write('Personality type along with mood are essential factors shaping song recommendation.'),nl,
	write('.................................................................................................'),
	nl,nl,
	checkout3);
	
	(ThirdOfFour='t';ThirdOfFour='f'),
	assertz(oneOfFour(ThirdOfFour));
	(ThirdOfFour='test3'),
	write('This test is to determine whether you are a Thinking or Feeling.'),nl,nl,
	write('Respond to statements'),nl,
	write('If statement is 0-49% true => answer f, if its 50-100% true => answer t'),nl,nl,nl,nl,
	test3,
	checkIfThinking(Char3, Display3),nl,
	write(Display3),nl,nl,
	assertz(oneOfFour(Char3))).
	
/*-----------------------------------------------------------------------------------*/
/* Help Judging Prospecting ---------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
checkout4:-
	getCorrectOptionJudgingProspecting(FourthOfFour),nl,
	
	(((FourthOfFour='why'),
	write('.................................................................................................'),nl,nl,
	write('Personality type consists of 4 main characteristics.'),nl,
	write('Judging or Prospecting defines the forth characteristic.'),nl,
	write('Personality type along with mood are essential factors shaping song recommendation.'),nl,
	write('.................................................................................................'),
	nl,nl,
	checkout4);
	
	(FourthOfFour='j';FourthOfFour='p'),
	assertz(oneOfFour(FourthOfFour));
	(FourthOfFour='test4'),
	write('This test is to determine whether you are a Judging or Prospecting.'),nl,nl,
	write('Respond to statements'),nl,
	write('If statement is 0-49% true => answer f, if its 50-100% true => answer t'),nl,nl,nl,nl,
	test4,
	checkIfJudging(Char4, Display4),nl,
	write(Display4),nl,nl,
	assertz(oneOfFour(Char4))).

/*-----------------------------------------------------------------------------------*/
/* Ensure user chose introvert i or extrovert e -------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectOptionIntrovertExtrovert(X):-
	repeat,
	write('Type i, e or test1: '),nl,
	write('=>why '),nl,
	read(Z),nl,
	checkOptionIntrovertExtrovert(Z),
	X=Z,!.
	
checkOptionIntrovertExtrovert('i').
checkOptionIntrovertExtrovert('e').
checkOptionIntrovertExtrovert('test1').
checkOptionIntrovertExtrovert('why').

/*-----------------------------------------------------------------------------------*/
/* Ensure user chose intuitive n or observant s -------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectOptionIntuitiveObservant(X):-
	repeat,
	write('Type n, s or test2: '),nl,
	write('=>why '),nl,
	read(Z),nl,
	checkOptionIntuitiveObservant(Z),
	X=Z,!.
	
checkOptionIntuitiveObservant('n').
checkOptionIntuitiveObservant('s').
checkOptionIntuitiveObservant('test2').
checkOptionIntuitiveObservant('why').

/*-----------------------------------------------------------------------------------*/
/* Ensure user chose thinking t or feeling f ----------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectOptionThinkingFeeling(X):-
	repeat,
	write('Type t, f or or test3: '),nl,
	write('=>why '),nl,
	read(Z),nl,
	checkOptionThinkingFeeling(Z),
	X=Z,!.
	
checkOptionThinkingFeeling('t').
checkOptionThinkingFeeling('f').
checkOptionThinkingFeeling('test3').
checkOptionThinkingFeeling('why').

/*-----------------------------------------------------------------------------------*/
/* Ensure user chose judging j or prospecting p -------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectOptionJudgingProspecting(X):-
	repeat,
	write('Type j, p or test4: '),nl,
	write('=>why '),nl,
	read(Z),nl,
	checkOptionJudgingProspecting(Z),
	X=Z,!.
	
checkOptionJudgingProspecting('j').
checkOptionJudgingProspecting('p').
checkOptionJudgingProspecting('test4').
checkOptionJudgingProspecting('why').

/*-----------------------------------------------------------------------------------*/
/* Test introvert or extrovert-------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/


test1:-
	q1,
	q2,
	q3.
	
	
q1:-
	questionsIntrovertExtrovert1(NumT1Q1,QT1Q1),
	write(QT1Q1),nl,nl,
	/*(questionsIntrovertExtrovert1(NumTe1Qu1,QTe1Qu1),*/
	getTrueFalse(TrueFalseT1Q1),
	(((TrueFalseT1Q1='why'),
	write('.................................................................................................'),nl,nl,
	write('These statements are true about Extroverts\nIf you identify with them you are an Extrovert\nIf not, you are an Introvert.'),nl,
	write('.................................................................................................'),
	nl,nl,
	q1);
	
	((TrueFalseT1Q1='f'),
	assertz(introvert(NumT1Q1));
	(TrueFalseT1Q1='t'),
	assertz(extrovert(NumT1Q1)))).
	
q2:-
questionsIntrovertExtrovert2(NumT1Q2,QT1Q2),
	write(QT1Q2),nl,nl,
	/*questionsIntrovertExtrovert2(NumT1Q2,QTe1Qu2),*/
	getTrueFalse(TrueFalseT1Q2),
	(((TrueFalseT1Q2='why'),
	write('.................................................................................................'),nl,nl,
	write('These statements are true about Extroverts\nIf you identify with them you are an Extrovert\nIf not, you are an Introvert.'),nl,
	write('.................................................................................................'),
	nl,nl,
	q2);
	
	((TrueFalseT1Q2='f'),
	assertz(introvert(NumT1Q2));
	(TrueFalseT1Q2='t'),
	assertz(extrovert(NumT1Q2)))).
	
q3:-
	questionsIntrovertExtrovert3(NumT1Q3,QT1Q3),
	write(QT1Q3),nl,nl,
	/*questionsIntrovertExtrovert2(NumT1Q3,QTe1Qu3),*/
	getTrueFalse(TrueFalseT1Q3),
	(((TrueFalseT1Q3='why'),
	write('.................................................................................................'),nl,nl,
	write('These statements are true about Extroverts\nIf you identify with them you are an Extrovert\nIf not, you are an Introvert.'),nl,
	write('.................................................................................................'),
	nl,nl,
	q3);
	
	((TrueFalseT1Q3='f'),
	assertz(introvert(NumT1Q3));
	(TrueFalseT1Q3='t'),
	assertz(extrovert(NumT1Q3)))).
	

/*-----------------------------------------------------------------------------------*/
/* Test intuitive or observant-------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

test2:-

	qInt1,
	qInt2,
	qInt3.

	
qInt1:-
	questionsIntuitiveObservant1(NumT2Q1,QT2Q1),
	write(QT2Q1),nl,nl,
	getTrueFalse(TrueFalseT2Q1),
	(((TrueFalseT2Q1='why'),
	write('.................................................................................................'),nl,nl,
	write('These statements are true about Intuitives\nIf you identify with them you are an Intuitive\nIf not, you are an Observant.'),nl,
	write('.................................................................................................'),
	nl,nl,
	qInt1);
	
	((TrueFalseT2Q1='f'),
	assertz(observant(NumT2Q1));
	(TrueFalseT2Q1='t'),
	assertz(intuitive(NumT2Q1)))).	
	
qInt2:-
	questionsIntuitiveObservant2(NumT2Q2,QT2Q2),
	write(QT2Q2),nl,nl,
	getTrueFalse(TrueFalseT2Q2),
	(((TrueFalseT2Q2='why'),
	write('.................................................................................................'),nl,nl,
	write('These statements are true about Intuitives\nIf you identify with them you are an Intuitive\nIf not, you are an Observant.'),nl,
	write('.................................................................................................'),
	nl,nl,
	qInt2);
	
	((TrueFalseT2Q2='f'),
	assertz(observant(NumT2Q2));
	(TrueFalseT2Q2='t'),
	assertz(intuitive(NumT2Q2)))).	
	
qInt3:-
	questionsIntuitiveObservant3(NumT2Q3,QT2Q3),
	write(QT2Q3),nl,nl,
	getTrueFalse(TrueFalseT2Q3),
	(((TrueFalseT2Q3='why'),
	write('.................................................................................................'),nl,nl,
	write('These statements are true about Intuitives\nIf you identify with them you are an Intuitive\nIf not, you are an Observant.'),nl,
	write('.................................................................................................'),
	nl,nl,
	qInt3);
	
	((TrueFalseT2Q3='f'),
	assertz(observant(NumT2Q3));
	(TrueFalseT2Q3='t'),
	assertz(intuitive(NumT2Q3)))).

/*-----------------------------------------------------------------------------------*/
/* Test thinking or feeling----------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

test3:-
	
	qThi1,
	qThi2,
	qThi3.

	
qThi1:-
	questionsThinkingFeeling1(NumT3Q1,QT3Q1),
	write(QT3Q1),nl,nl,
	getTrueFalse(TrueFalseT3Q1),
	(((TrueFalseT3Q1='why'),
	write('.................................................................................................'),nl,nl,
	write('These statements are true about Thinkings\nIf you identify with them you are a Thinking\nIf not, you are a Feeling.'),nl,
	write('.................................................................................................'),
	nl,nl,
	qThi1);
	
	((TrueFalseT3Q1='f'),
	assertz(feeling(NumT3Q1));
	(TrueFalseT3Q1='t'),
	assertz(thinking(NumT3Q1)))).	
	
qThi2:-
	questionsThinkingFeeling2(NumT3Q2,QT3Q2),
	write(QT3Q2),nl,nl,
	getTrueFalse(TrueFalseT3Q2),
	(((TrueFalseT3Q2='why'),
	write('.................................................................................................'),nl,nl,
	write('These statements are true about Thinkings\nIf you identify with them you are a Thinking\nIf not, you are a Feeling.'),nl,
	write('.................................................................................................'),
	nl,nl,
	qThi2);
	
	((TrueFalseT3Q2='f'),
	assertz(feeling(NumT3Q2));
	(TrueFalseT3Q2='t'),
	assertz(thinking(NumT3Q2)))).	
	
qThi3:-
	questionsThinkingFeeling3(NumT3Q3,QT3Q3),
	write(QT3Q3),nl,nl,
	getTrueFalse(TrueFalseT3Q3),
	(((TrueFalseT3Q3='why'),
	write('.................................................................................................'),nl,nl,
	write('These statements are true about Thinkings\nIf you identify with them you are a Thinking\nIf not, you are a Feeling.'),nl,
	write('.................................................................................................'),
	nl,nl,
	qThi3);
	
	((TrueFalseT3Q3='f'),
	assertz(feeling(NumT3Q3));
	(TrueFalseT3Q3='t'),
	assertz(thinking(NumT3Q3)))).

/*-----------------------------------------------------------------------------------*/
/* Test judging or prospecting-------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

test4:-
	qJud1,
	qJud2,
	qJud3.

	
qJud1:-
	questionsJudgingProspecting1(NumT4Q1,QT4Q1),
	write(QT4Q1),nl,nl,
	getTrueFalse(TrueFalseT4Q1),
	(((TrueFalseT4Q1='why'),
	write('.................................................................................................'),nl,nl,
	write('These statements are true about Judgings\nIf you identify with them you are a Judging\nIf not, you are a Prospecting.'),nl,
	write('.................................................................................................'),
	nl,nl,
	qJud1);
	
	((TrueFalseT4Q1='f'),
	assertz(prospecting(NumT4Q1));
	(TrueFalseT4Q1='t'),
	assertz(judging(NumT4Q1)))).	
	
qJud2:-
	questionsJudgingProspecting2(NumT4Q2,QT4Q2),
	write(QT4Q2),nl,nl,
	getTrueFalse(TrueFalseT4Q2),
	(((TrueFalseT4Q2='why'),
	write('.................................................................................................'),nl,nl,
	write('These statements are true about Judgings\nIf you identify with them you are a Judging\nIf not, you are a Prospecting.'),nl,
	write('.................................................................................................'),
	nl,nl,
	qJud2);
	
	((TrueFalseT4Q2='f'),
	assertz(prospecting(NumT4Q2));
	(TrueFalseT4Q2='t'),
	assertz(judging(NumT4Q2)))).	
	
qJud3:-
	questionsJudgingProspecting3(NumT4Q3,QT4Q3),
	write(QT4Q3),nl,nl,
	getTrueFalse(TrueFalseT4Q3),
	(((TrueFalseT4Q3='why'),
	write('.................................................................................................'),nl,nl,
	write('These statements are true about Judgings\nIf you identify with them you are a Judging\nIf not, you are a Prospecting.'),nl,
	write('.................................................................................................'),
	nl,nl,
	qJud3);
	
	((TrueFalseT4Q3='f'),
	assertz(prospecting(NumT4Q3));
	(TrueFalseT4Q3='t'),
	assertz(judging(NumT4Q3)))).

/*-----------------------------------------------------------------------------------*/
/* Ensure user answers true t or false f --------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getTrueFalse(X):-
	repeat,
	write('Type t or f: '),nl,
	write('=>why '),nl,
	read(Z),nl,
	checkTrueFalse(Z),
	X=Z,!.
	
checkTrueFalse('t').
checkTrueFalse('f').
checkTrueFalse('why').


/*-----------------------------------------------------------------------------------*/
/* Conditions for Introverts vs Extroverts ------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

checkIfIntrovert(i, 'You are an Introvert.'):-(introvert(1),introvert(2),introvert(3));
(introvert(1),introvert(2));(introvert(1),introvert(3));(introvert(2),introvert(3)).
checkIfIntrovert(e, 'You are an Extrovert.'):-((extrovert(1),extrovert(2),extrovert(3));
(extrovert(1),extrovert(2));(extrovert(1),extrovert(3));(extrovert(2),extrovert(3))).

/*-----------------------------------------------------------------------------------*/
/* Conditions for Intuitive vs Observant ------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

checkIfIntuitive(n, 'You are an Intuitive.'):-(intuitive(1),intuitive(2),intuitive(3));
(intuitive(1),intuitive(2));(intuitive(1),intuitive(3));(intuitive(2),intuitive(3)).
checkIfIntuitive(s, 'You are an Observant.'):-(observant(1),observant(2),observant(3));
(observant(1),observant(2));(observant(1),observant(3));(observant(2),observant(3)).


/*-----------------------------------------------------------------------------------*/
/* Conditions for Thinking vs Feeling -----------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

checkIfThinking(t, 'You are a Thinking.'):-(thinking(1),thinking(2),thinking(3));
(thinking(1),thinking(2));(thinking(1),thinking(3));(thinking(2),thinking(3)).
checkIfThinking(f, 'You are a Feeling.'):-(feeling(1),feeling(2),feeling(3));
(feeling(1),feeling(2));(feeling(1),feeling(3));(feeling(2),feeling(3)).


/*-----------------------------------------------------------------------------------*/
/* Conditions for Judging vs Prospecting --------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

checkIfJudging(j, 'You are a Judging.'):-(judging(1),judging(2),judging(3));
(judging(1),judging(2));(judging(1),judging(3));(judging(2),judging(3)).
checkIfJudging(p, 'You are a Prospecting.'):-(prospecting(1),prospecting(2),prospecting(3));
(prospecting(1),prospecting(2));(prospecting(1),prospecting(3));(prospecting(2),prospecting(3)).


/*-----------------------------------------------------------------------------------*/
/* 4 questions about characteristics forming personality type -----------------------*/
/*-----------------------------------------------------------------------------------*/

giveSupportQuestionsBroad1('Are you Introvert => i or Extrovert => e or do you need help deciding => test1?: ').
giveSupportQuestionsBroad2('Are you Intuitive => n or Observant => s? or do you need help deciding => test2?: ').
giveSupportQuestionsBroad3('Are you Thinking => t or Feeling => f? or do you need help deciding => test3?: ').
giveSupportQuestionsBroad4('Are you Judging => j or Prospecting => p? or do you need help deciding => test4?: ').


/*-----------------------------------------------------------------------------------*/
/* Determine personality type based on 4 responses to questions ---------------------*/
/*-----------------------------------------------------------------------------------*/

personalityType(1, intj, 'Your personality type: architect, intj.'):-
	oneOfFour(i),oneOfFour(n),oneOfFour(t),oneOfFour(j).
personalityType(2, intp, 'Your personality type: logician, intp.'):-
	oneOfFour(i),oneOfFour(n),oneOfFour(t),oneOfFour(p).
personalityType(3, entj, 'Your personality type: commander, entj.'):-
	oneOfFour(e),oneOfFour(n),oneOfFour(t),oneOfFour(j).
personalityType(4, entp, 'Your personality type: debater, entp.'):-
	oneOfFour(e),oneOfFour(n),oneOfFour(t),oneOfFour(p).
personalityType(5, infj, 'Your personality type: advocate, infj.'):-
	oneOfFour(i),oneOfFour(n),oneOfFour(f),oneOfFour(j).
personalityType(6, infp, 'Your personality type: mediator, infp.'):-
	oneOfFour(i),oneOfFour(n),oneOfFour(f),oneOfFour(p).
personalityType(7, enfj, 'Your personality type: protagonist, enfj.'):-
	oneOfFour(e),oneOfFour(n),oneOfFour(f),oneOfFour(j).
personalityType(8, enfp, 'Your personality type: campaigner, enfp.'):-
	oneOfFour(e),oneOfFour(n),oneOfFour(f),oneOfFour(p).
personalityType(9, istj, 'Your personality type: logistician, istj.'):-
	oneOfFour(i),oneOfFour(s),oneOfFour(t),oneOfFour(j).
personalityType(10, isfj, 'Your personality type: defender, isfj.'):-
	oneOfFour(i),oneOfFour(s),oneOfFour(f),oneOfFour(j).
personalityType(11, estj, 'Your personality type: executive, estj.'):-
	oneOfFour(e),oneOfFour(s),oneOfFour(t),oneOfFour(j).
personalityType(12, esfj, 'Your personality type: consul, esfj.'):-
	oneOfFour(e),oneOfFour(s),oneOfFour(f),oneOfFour(j).
personalityType(13, istp, 'Your personality type: virtuoso, istp.'):-
	oneOfFour(i),oneOfFour(s),oneOfFour(t),oneOfFour(p).
personalityType(14, isfp, 'Your personality type: adventurer, isfp.'):-
	oneOfFour(i),oneOfFour(s),oneOfFour(f),oneOfFour(p).
personalityType(15, estp, 'Your personality type: entrepreneur, estp.'):-
	oneOfFour(e),oneOfFour(s),oneOfFour(t),oneOfFour(p).
personalityType(16, esfp, 'Your personality type: entertainer, esfp.'):-
	oneOfFour(e),oneOfFour(s),oneOfFour(f),oneOfFour(p).
	
/*-----------------------------------------------------------------------------------*/
/* Personality and its genres -------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
	
personalityAndGenres(1,intj,'electronic','classical','metal'):-personality(intj).
personalityAndGenres(2,intp,'rock', 'classical', 'metal'):-personality(intp).
personalityAndGenres(3,entj,'rock', 'alternative', 'indie'):-personality(entj).
personalityAndGenres(4,entp,'rock', 'blues', 'indie'):-personality(entp).
personalityAndGenres(5,infj,'indie_rock', 'classical', 'folk'):-personality(infj).
personalityAndGenres(6,infp,'rock', 'metal', 'folk'):-personality(infp).
personalityAndGenres(7,enfj,'world', 'indie', 'alternative'):-personality(enfj).
personalityAndGenres(8,enfp,'rock', 'alternative', 'pop'):-personality(enfp).
personalityAndGenres(9,istj,'rock', 'alternative', 'pop'):-personality(istj).
personalityAndGenres(10,isfj,'soft_rock', 'alternative', 'indie'):-personality(isfj).
personalityAndGenres(11,estj, 'rock', 'electronic', 'pop'):-personality(estj).
personalityAndGenres(12,esfj,'musicals', 'pop', 'country'):-personality(esfj).
personalityAndGenres(13,istp,'classic_rock', 'metal', 'alternative'):-personality(istp).
personalityAndGenres(14,isfp,'rock', 'classical', 'alternative'):-personality(isfp).
personalityAndGenres(15,estp,'hip_hop', 'electronic', 'rap'):-personality(estp).
personalityAndGenres(16,esfp,'alternative', 'rock', 'rap'):-personality(esfp).
	
/*-----------------------------------------------------------------------------------*/
/* Ask user about mood---------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

collect_mood:-
	
	getCorrectMood(Mood),nl,
	
	(((Mood='why'),
	write('.................................................................................................'),nl,nl,
	write('Mood is essential factor shaping song recommendation.'),nl,
	write('Song ambience will reflect your mood.'),nl,
	write('.................................................................................................'),
	nl,nl,
	collect_mood);
	
	(Mood='good';Mood='bad'),
	assertz(mood(Mood))).
	
	
	
/*-----------------------------------------------------------------------------------*/
/* Ensure user types good or bad mood -------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getCorrectMood(X):-
	repeat,
	write('Type good or bad: '),nl,
	write('=>why'),nl,
	read(Z),nl,
	checkMood(Z),
	X=Z,!.
	
checkMood('good').
checkMood('bad').
checkMood('why').

/*-----------------------------------------------------------------------------------*/
/* Collect genre preferation --------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

collect_preferred_genre:-

	getAllowedGenre(GenrePreferation),nl,
	
	(((GenrePreferation='why'),
	write('.................................................................................................'),nl,nl,
	write('You are asked about genre preferation to ensure you are happy about suggested genre.'),nl,
	write('UNLESS you are happy, you can always choose the one you believe is a better match for your personality.'),nl,
	write('.................................................................................................'),
	nl,nl,
	collect_preferred_genre);
	
	(GenrePreferation='electronic';GenrePreferation='classical';GenrePreferation='metal';GenrePreferation='rock';
	GenrePreferation='alternative';GenrePreferation='indie';GenrePreferation='blues';GenrePreferation='indie_rock';
	GenrePreferation='folk';GenrePreferation='world';GenrePreferation='pop';GenrePreferation='soft_rock';
	GenrePreferation='musicals';GenrePreferation='country';GenrePreferation='classic_rock';GenrePreferation='hip_hop';
	GenrePreferation='rap'),
	assertz(genrePreferation(GenrePreferation))).
	
	

/*-----------------------------------------------------------------------------------*/
/* Check user types one of the allowed genres ---------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getAllowedGenre(X):-
	repeat,
	write('Type ONE from the recommended genres or ONE from the list below: '),nl,nl,
	write('All genres:    '),nl,
	write('electronic, classical, metal, rock,'),nl,
	write('alternative, indie, blues, indie_rock,'),nl,
	write('folk, world, pop, soft_rock,'),nl,
	write('musicals, country, classic_rock, hip_hop, rap'),nl,
	write('=>why'),nl,
	read(Z),nl,
	checkGenre(Z),
	X=Z,!.
	
checkGenre('electronic').
checkGenre('classical').
checkGenre('metal').
checkGenre('rock').
checkGenre('alternative').
checkGenre('indie').
checkGenre('blues').
checkGenre('indie_rock').
checkGenre('folk').
checkGenre('world').
checkGenre('pop').
checkGenre('soft_rock').
checkGenre('musicals').
checkGenre('country').
checkGenre('classic_rock').
checkGenre('hip_hop').
checkGenre('rap').
checkGenre('why').






/*-----------------------------------------------------------------------------------*/
/* Songs ----------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

song(1,'Riton, RAYE - I Dont Want You','https://www.youtube.com/watch?v=Bkwy6OD55Xo',electronic,good):-
	genrePreferation(electronic), mood(good).
song(2,'Martin Garrix - Animals','https://www.youtube.com/watch?v=gCYcHz2k5x0',electronic,bad):-
	genrePreferation(electronic), mood(bad).
song(3,'J.S. Bach - Toccata and Fugue in D minor BWV 565','https://www.youtube.com/watch?v=Nnuq9PXbywA',classical,good):-
	genrePreferation(classical), mood(good).
song(4,'Beethoven - Fur Elise','https://www.youtube.com/watch?v=_mVW8tgGY_w',classical,good):-
	genrePreferation(classical), mood(bad).
song(5,'Master Of Puppets','https://www.youtube.com/watch?v=S7blkui3nQc',metal,good):-
	genrePreferation(metal), mood(good).
song(6,'Iron Maiden - Hallowed Be Thy Name','https://www.youtube.com/watch?v=J51LPlP-s9o',metal,bad):-
	genrePreferation(metal), mood(bad).
song(7,'AC/DC - Back In Black','https://www.youtube.com/watch?v=pAgnJDJN4VA',rock,good):-
	genrePreferation(rock), mood(good).
song(8,'Queen - Somebody To Love','https://www.youtube.com/watch?v=kijpcUv-b8M',rock,bad):-
	genrePreferation(rock), mood(bad).
song(9,'Creed - My Sacrifice','https://www.youtube.com/watch?v=O-fyNgHdmLI',alternative,good):-
	genrePreferation(alternative), mood(good).
song(10,'3 Doors Down - Here Without You','https://www.youtube.com/watch?v=kPBzTxZQG5Q',alternative,bad):-
	genrePreferation(alternative), mood(bad).
song(11,'Joy Division - Love Will Tear Us Apart','https://www.youtube.com/watch?v=zuuObGsB0No',indie,good):-
	genrePreferation(indie), mood(good).
song(12,'The Smiths - This Charming Man','https://www.youtube.com/watch?v=cJRP3LRcUFg',indie,bad):-
	genrePreferation(indie), mood(bad).
song(13,'Sam Myers - I Got The Blues','https://www.youtube.com/watch?v=N-KluFB9A8M',blues, good):-
	genrePreferation(blues), mood(good).
song(14,'Chris Bell 100 Blues - Cold Hearted Woman','https://www.youtube.com/watch?v=AOWmPwKbcn4',blues, bad):-
	genrePreferation(blues), mood(bad).
song(15,'Parks, Squares and Alleys - We Are Not Just Friends','https://www.youtube.com/watch?v=M3IWsWzSo14',indie_rock,good):-
	genrePreferation(indie_rock), mood(good).
song(16,'Johnny Goth - Feels like We Are Dying','https://www.youtube.com/watch?v=Jej2f7tOsvI',indie_rock,bad):-
	genrePreferation(indie_rock), mood(bad).
song(17,'This Land is Your Land- Woody Guthrie','https://www.youtube.com/watch?v=Ol0rRdF5L1c',folk,good):-
	genrePreferation(folk), mood(good).
song(18,'Bob Dylan - Like a Rolling Stone','https://www.youtube.com/watch?v=IwOfCgkyEj0',folk,bad):-
	genrePreferation(folk), mood(bad).
song(19,'1 Hour of World Music - Music From Different Cultures','https://www.youtube.com/watch?v=DAhLXLj4UuE',world,good):-
	genrePreferation(world), mood(good).
song(20,'Beautiful World Music SET - MASALA','https://www.youtube.com/watch?v=tp_y1B1eQeo',world,bad):-
	genrePreferation(world), mood(bad).
song(21,'Ed Sheeran - Shape of You','https://www.youtube.com/watch?v=JGwWNGJdvx8',pop,good):-
	genrePreferation(pop), mood(good).
song(22,'Sam Smith - I am Not The Only One','https://www.youtube.com/watch?v=nCkpzqqog4k',pop,bad):-
	genrePreferation(pop), mood(bad).
song(23,'Foreigner - I Want To Know What Love Is','https://www.youtube.com/watch?v=r3Pr1_v7hsw',soft_rock,good):-
	genrePreferation(soft_rock), mood(good).
song(24,'The Police - Every Breath You Take','https://www.youtube.com/watch?v=OMOGaugKpzs',soft_rock,bad):-
	genrePreferation(soft_rock), mood(bad).
song(25,'Sister Act- I Will Follow Him','https://www.youtube.com/watch?v=VPpd-6X3tEo',musicals,good):-
	genrePreferation(musicals), mood(good).
song(26,'Sister Act 2 - Oh Happy Day','https://www.youtube.com/watch?v=z-4mtA6Z88k',musicals,bad):-
	genrePreferation(musicals), mood(bad).
song(27,'Alan Jackson - Remember When','https://www.youtube.com/watch?v=TTA2buWlNyM',country,good):-
	genrePreferation(country), mood(good).
song(28,'Kenny Rogers - The Gambler','https://www.youtube.com/watch?v=7hx4gdlfamo',country,bad):-
	genrePreferation(country), mood(bad).
song(29,'Creedence Clearwater Revival: Have You Ever Seen The Rain?','https://www.youtube.com/watch?v=Gu2pVPWGYMQ',classic_rock,good):-
	genrePreferation(classic_rock), mood(good).
song(30,'Dire Straits - Sultans Of Swing','https://www.youtube.com/watch?v=h0ffIJ7ZO4U',classic_rock,bad):-
	genrePreferation(classic_rock), mood(bad).
song(31,'I Got 5 On It','https://www.youtube.com/watch?v=Dsct-TZ26Pw',hip_hop,good):-
	genrePreferation(hip_hop), mood(good).
song(32,'Fugees - Fu-Gee-La','https://www.youtube.com/watch?v=MPlb9HoOCxs',hip_hop,bad):-
	genrePreferation(hip_hop), mood(bad).
song(33,'Eminem - Lose Yourself','https://www.youtube.com/watch?v=_Yhyp-_hX2s',rap,good):-
	genrePreferation(rap), mood(good).
song(34,'Eminem - Without Me','https://www.youtube.com/watch?v=YVkUvmDQ3HY',rap,bad):-
	genrePreferation(rap), mood(bad).

showSong:-
	nl,nl,nl,
	write('Your song recommendation: '),nl,
	song(Number,Title,Url,Gen,Moodd),
	write(Title),nl,
	write(Url),nl,
	how.
	
	
how:-
	nl,nl,nl,nl,
	write('Type end to finish or how to find out how system produced your song recommendation'),nl,nl,
	getHow(How),
	((How='how'),
	write('.................................................................................................'),nl,nl,
	personalityAndGenres(A,B,C,D,E),
	write('Your personality type: '),
	write(B),nl,
	song(Number,Title,Url,Gen,Moodd),
	write('Your genre preferation: '),
	write(Gen),nl,
	write('Your current mood: '),
	write(Moodd),nl,
	write('Song recommended for these parametres: '),nl, 
	write(Title),nl,
	write(Url),
	write('.'),nl,
	write('.................................................................................................'),
	nl,nl);
	
	((How='end'),
	write('Thank you for using system. ')).
	

/*-----------------------------------------------------------------------------------*/
/* Check if user typed how -------------------------------------*/
/*-----------------------------------------------------------------------------------*/

getHow(X):-
	repeat,
	write('Type end to finish: '),nl,
	write('=>how'),nl,
	read(Z),nl,
	checkHow(Z),
	X=Z,!.
	
checkHow('how').
checkHow('end').

/*-----------------------------------------------------------------------------------*/
/* Questions for Introverts vs Extroverts -------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

questionsIntrovertExtrovert1(1,'I love public speaking.').
questionsIntrovertExtrovert2(2,'I enjoy meeting new people.').
questionsIntrovertExtrovert3(3,'Face to face or video/audio chat is my preferred way of communication.').

/*-----------------------------------------------------------------------------------*/
/* Questions for Intuitive vs Observant ---------------------------------------------*/
/*-----------------------------------------------------------------------------------*/	

questionsIntuitiveObservant1(1,'I spend a lot of time questioning, wondering and thinking about what if scenarios').
questionsIntuitiveObservant2(2,'I am more theoretical rather than practical.').		
questionsIntuitiveObservant3(3,'My mind often drifts off during a conversation.').

/*-----------------------------------------------------------------------------------*/
/* Questions for Thinking vs Feeling ------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

questionsThinkingFeeling1(1,'I make decisions with my head rather than with heart.').
questionsThinkingFeeling2(2,'I restrain from acting when experiencing extreme emotions.').
questionsThinkingFeeling3(3,'I assess different possibilities using logic and scientific approach.').

/*------------------------------------------------------------------------------------*/
/* Questions for Judging vs Prospecting ---------------------------------------------*/
/*-----------------------------------------------------------------------------------*/

questionsJudgingProspecting1(1,'I stick to the plan rather than going with the flow.').
questionsJudgingProspecting2(2,'Duties and responsibilities are above everything else.').
questionsJudgingProspecting3(3,'I prepare a lot of back up plans.').



















