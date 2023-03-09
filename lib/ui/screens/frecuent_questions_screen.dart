import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:itus_manager/model/question/QueryQuestion.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant/strings.dart';
import '../../provider/query_provider.dart';
import '../../services/ToastMessage.dart';
import '../../themes/colors.dart';
import '../generic_widgets/loading_widget.dart';
import '../generic_widgets/searchButton.dart';

class FrecuentQuestionsScreen extends StatefulWidget {
  FrecuentQuestionsScreen({Key? key}) : super(key: key);

  @override
  State<FrecuentQuestionsScreen> createState() => _FrecuentQuestionsScreenState();
}

class _FrecuentQuestionsScreenState extends State<FrecuentQuestionsScreen> {

  String? campaignValue;
  String? cicloNegocionValue;
  bool loading= false;
  final questionController = TextEditingController();
  String currentQueryText="";
  bool isLoading=false;
  bool isLoadingFullQuery=false;
  bool close=false;
  bool blockScroll=true;

  @override
  void initState() {
    context.read<QueryProvider>().clearAll();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.frecuentQuestionsTitle,
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.black,fontSize: 16),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: Consumer<QueryProvider>(
        builder: (context, query, child) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              physics: blockScroll? const NeverScrollableScrollPhysics():null,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*1.3),
                child:  Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:  Text(
                          "${query.currentQueryUser.name} ${query.currentQueryUser.lastname}",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black,fontSize: 20),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),

                    Expanded(
                        flex: 6,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          color: lightGrey.withOpacity(0.1),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: _campaignChooser()
                              ),
                              Expanded(
                                  flex: 2,
                                  child: _campaignBusinessCycle()
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Container(),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Align(
                                                        child: SearchButton(
                                                          onPressed: ()async{
                                                            setState(() {isLoadingFullQuery=true;});
                                                            await Provider.of<QueryProvider>(context, listen: false).updateFullQuestionsQuery(currentQueryText);
                                                            setState(() {isLoadingFullQuery=false;});
                                                            if(query.fullQuestionsQuery!=null){
                                                              setState(() {blockScroll=false;});
                                                            }else{
                                                              setState(() {blockScroll=true;});
                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(Strings.queryFail),backgroundColor: Colors.red,));
                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                            }
                                                          },
                                                        )
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(),
                                            ),
                                          ],
                                        ),
                                        questionSpace()
                                      ],
                                    )
                                ),
                              )
                            ],
                          ),
                        )
                    ),

                    Expanded(
                        flex: 7,
                        child: Container(
                            child: query.fullQuestionsQuery==null?
                            Container()
                                :
                            Column(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            flex: 4,
                                            child: Divider(
                                              color: mainGreen,
                                              thickness: 3,
                                            )
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "${query.fullQuestionsQuery!.meta.current_page}-${query.fullQuestionsQuery!.meta.last_page}",
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headlineMedium
                                                    ?.copyWith(color: Colors.black,fontSize: 20),
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            )
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: InkWell(
                                                onTap: ()async{
                                                  if(query.fullQuestionsQuery!.links.prev!=null){
                                                    setState(() {isLoadingFullQuery=true;});
                                                    await Provider.of<QueryProvider>(context, listen: false).updateFullQuestionsQueryFromUrl(query.fullQuestionsQuery!.links.prev!);
                                                    setState(() {isLoadingFullQuery=false;});
                                                  }
                                                },
                                                child:  Center(
                                                  child:  Icon(
                                                    Icons.arrow_circle_left,
                                                    size: 30,
                                                    color: query.fullQuestionsQuery!.links.prev==null?lightGrey:mainGreen,
                                                  ),
                                                )
                                            )
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: InkWell(
                                                onTap: ()async{
                                                  if(query.fullQuestionsQuery!.links.next!=null){
                                                    setState(() {isLoadingFullQuery=true;});
                                                    await Provider.of<QueryProvider>(context, listen: false).updateFullQuestionsQueryFromUrl(query.fullQuestionsQuery!.links.next!);
                                                    setState(() {isLoadingFullQuery=false;});
                                                  }
                                                },
                                                child:  Center(
                                                  child:  Icon(
                                                    Icons.arrow_circle_right,
                                                    size: 30,
                                                    color: query.fullQuestionsQuery!.links.next==null?lightGrey:mainGreen,
                                                  ),
                                                )
                                            )
                                        ),
                                      ],
                                    )
                                ),
                                Expanded(
                                  flex: 5,
                                  child: isLoadingFullQuery?
                                  LoadingWidget()
                                      :
                                  ListView.builder(
                                      itemCount: query.fullQuestionsQuery!.data.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return fullQueryListItem(index, query.fullQuestionsQuery!.data.elementAt(index));
                                      }
                                  ),
                                )
                              ],
                            )
                        )
                    )
                  ],
                ),
              ),
            )
          );
        },
      ),
    );
  }

  Widget _campaignChooser(){
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              Strings.camapannasTitle,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black, fontSize: 14),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(
              top: 5,
              bottom: 5
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: lightGrey.withOpacity(0.3),width: 1.5),
              color: Colors.white,
            ),
            child:  DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  Strings.chooseCampaignTitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme
                        .of(context)
                        .hintColor,
                  ),
                ),
                value: campaignValue,
                items: context.watch<QueryProvider>().campaigns.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child:  Text(
                      item.toLowerCase(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue)async{
                  setState(() {
                    campaignValue = newValue!;
                    loading=true;
                  });
                  Provider.of<QueryProvider>(context, listen: false).clearCurrentQuestionQuery();
                  questionController.clear();
                  await Provider.of<QueryProvider>(context, listen: false).updateCampainsBusinessCycles(campaignValue!);
                  setState(() {
                    cicloNegocionValue=(Provider.of<QueryProvider>(context, listen: false).campaignsBusinessCycles).first;
                    loading=false;
                  });
                },
            )
          ),
        )
      ],
    );

  }


  Widget _campaignBusinessCycle(){
    try{
      return Column(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                Strings.businessCycleTitle,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black, fontSize: 14),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
                margin: const EdgeInsets.only(
                    top: 5,
                    bottom: 5
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: lightGrey.withOpacity(0.3),width: 1.5),
                  color: Colors.white,
                ),
                child: loading?
                LoadingWidget()
                    :
                DropdownButton<String>(
                  isExpanded: true,
                  value: cicloNegocionValue,

                  hint: Text(
                    Strings.chooseBusinessCycleTitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme
                          .of(context)
                          .hintColor,
                    ),
                  ),
                  items: context.watch<QueryProvider>().campaignsBusinessCycles.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child:  Text(
                        item.toLowerCase(),
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue){
                    setState(() {
                      cicloNegocionValue=newValue!;
                      Provider.of<QueryProvider>(context, listen: false).clearCurrentQuestionQuery();
                      questionController.clear();
                    });
                  },
                )
            ),
          )
        ],
      );
    }catch(e){
      return Column(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                Strings.businessCycleTitle,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black, fontSize: 14),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
                margin: const EdgeInsets.only(
                    top: 5,
                    bottom: 5
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: lightGrey.withOpacity(0.3),width: 1.5),
                  color: Colors.white,
                ),
                child: LoadingWidget()
            ),
          )
        ],
      );
    }
  }


  Widget questionSpace(){
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              Strings.questionTitle,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black, fontSize: 14),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: _questionSearchBar(),
        )
      ],
    );
  }


  Widget _questionSearchBar(){
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: lightGrey.withOpacity(0.4),width: 1.2),
              color: Colors.white,
            ),
            child: TextFormField(
              controller: questionController,
              onChanged: (value)async{
                try{
                  setState(() {
                    close=false;
                    isLoading=true;
                    currentQueryText=value;
                  });
                  if(currentQueryText.isNotEmpty){
                    await await Provider.of<QueryProvider>(context, listen: false).
                    updateCurrentQuestionsQuery(campaignValue!,cicloNegocionValue!, currentQueryText);
                    setState(() {
                      isLoading=false;
                    });
                  }else{
                    Provider.of<QueryProvider>(context, listen: false).clearCurrentQuestionQuery();
                  }
                }catch(e){
                  ToastMessage.genericMessage(Strings.questionError);
                }
              },
              style:Theme
                  .of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black, fontSize: 14),

              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    top: 15
                ),
                hintText: Strings.questionTitle,
                hintStyle: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey, fontSize: 14),

                enabledBorder:  const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder:  const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                border:  const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            )
        ),
        _queryList()
      ],
    );


  }


  Widget _queryList(){
    double height=100;
    return Consumer<QueryProvider>(
      builder: (context, query, child) {
        if(currentQueryText.isNotEmpty && query.currentQuestionsQuery!=null && !close){
          if(isLoading){
            return  Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: lightGrey.withOpacity(0.3),width: 1),
              ),
              child: Center(
                child: LoadingWidget(),
              ),
            );
          }else{
            return  Container(
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: lightGrey.withOpacity(0.3),width: 1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: (query.currentQuestionsQuery!.data.isEmpty)?
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          Strings.queryFail,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      )
                          :
                      ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: lightGrey,
                            );
                          },
                          itemCount: query.currentQuestionsQuery!.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  questionController.text=query.currentQuestionsQuery!.data.elementAt(index).question;
                                  currentQueryText=questionController.text;
                                  close=true;
                                  FocusManager.instance.primaryFocus?.unfocus();
                                });
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  query.currentQuestionsQuery!.data.elementAt(index).question,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.black),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            );
                          }
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child:  SizedBox(
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: InkWell(
                            child: const Icon(
                              Icons.close,
                              color: mainOrange,
                              size: 30,
                            ),
                            onTap: (){
                              setState(() {
                                close=true;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                  ],
                )
            );
          }
        }else{
          return Container();
        }
      },
    );

  }

  Widget fullQueryListItem(int index, QueryQuestion question){
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      color: (index%2==0)?lightGrey.withOpacity(0.1):Colors.white,
      child: Column(
        children: [

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              question.question,
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.black,fontSize: 14),
              textAlign: TextAlign.start,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "${question.campaign}/${question.business}",
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: mainGreen,fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Linkify(
              onOpen: (link) async {
                await launchUrl(Uri.parse(link.url));
              },
              text: question.answer,
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.black,fontSize: 12),
              linkStyle: const TextStyle(color: mainGreen),
            )
          ),
        ],
      ),
    );
  }


}


