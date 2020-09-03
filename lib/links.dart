


class API{
  String linkList(int userId ,String token){
    return 'http://apiiq.bigorder.vn/api/v1/topic/list-category?userid=${userId}&token=${token}';
  }
  String Topic(int cateId, int userId, String token){
    return 'http://apiiq.bigorder.vn/api/v1/topic/list-topic?category_id=${cateId}&token=${token}&userid=${userId}';
  }

  String TopicTest(int topicId, int userId, String token){
    return 'http://apiiq.bigorder.vn/api/v1/topic/topic-test?topic_id=${topicId}&token=${token}&userid=${userId}';
  }
}


