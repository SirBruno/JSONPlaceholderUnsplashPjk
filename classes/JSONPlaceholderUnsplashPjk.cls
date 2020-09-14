public class JSONPlaceholderUnsplashPjk {
    public static String pageNumber { get; set; }

    public JSONPlaceholderUnsplashPjk () {
        pageNumber = '1';
    }

    public static Map<Object, Object> getImageData() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        if (Apexpages.currentPage().getParameters().get('pageNumber') == NULL) {
            request.setEndpoint('https://api.unsplash.com/photos?client_id=59I_rlGU2KQHyoJy6R1_K6gfjiNpuXq8y7uz8UEUbRk&page=1');
        } else {
            request.setEndpoint('https://api.unsplash.com/photos?client_id=59I_rlGU2KQHyoJy6R1_K6gfjiNpuXq8y7uz8UEUbRk&page='+Apexpages.currentPage().getParameters().get('pageNumber'));
        }
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
        Map<Object, Object> dataMap = new Map<Object, Object>();
        List<Object> results = (List<Object>)JSON.deserializeUntyped(response.getBody());
    
        for (Object r : results) {
            Map<String, Object> data = (Map<String, Object>)r;
            dataMap.put(data.get('id'), data.get('urls'));
        }
        System.debug(pageNumber);

        return dataMap;
        } else return null;
    }

	public static Map<Object, Object> getData(){
		Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        if (Apexpages.currentPage().getParameters().get('pageNumber') == NULL) {
            request.setEndpoint('https://jsonplaceholder.typicode.com/users/1/posts');
        } else {
            request.setEndpoint('https://jsonplaceholder.typicode.com/users/'+Apexpages.currentPage().getParameters().get('pageNumber')+'/posts');
        }

		request.setMethod('GET');
		HttpResponse response = http.send(request);
		if (response.getStatusCode() == 200){
			Map<Object, Object> dataMap = new Map<Object, Object>();
            List<Object> results = (List<Object>)JSON.deserializeUntyped(response.getBody());
            
            // Get the post's images
            List<String> imageUrls = new List<String>();

			for (Object o : getImageData().values()) {
                Map<String, Object> imgUrl = (Map<String, Object>)o;
                imageUrls.add((String)imgUrl.get('regular'));
            }

            Integer counter = 0;
			for (Object r : results){
				Map<String, Object> data = (Map<String, Object>)r;
				String postBodyJSON = '{"id":"' + data.get('id')+'", "title":"' + data.get('title')+'", "body":"' + data.get('body')+'", "postImage":"'+ imageUrls[counter] +'"}';
				Object postBody = JSON.deserializeUntyped(postBodyJSON.replaceAll('\n', '').replaceAll('\r', ''));
                dataMap.put(data.get('id'), postBody);
                
                counter++;
            }

			return dataMap;
		} else
			return null;
	}

	public String postId{ get; set; }
	public String postImgUrl{ get; set; }

	public PageReference gotoPage(){
		PageReference pr = Page.JSONPlaceholderPjkSingle;
		pr.getParameters().put('postId', this.postId);
        pr.getParameters().put('postImgUrl', this.postImgUrl);

		pr.setRedirect(true);
		return pr;
	}

	public PageReference gotoPageSingle(){
		PageReference pr = Page.JSONPlaceholderPjk;
		pr.setRedirect(true);
		return pr;
    }
    
    public PageReference nextPage() {
        PageReference pr = Page.JSONPlaceholderPjk;
        pr.getParameters().put('pageNumber', pageNumber);
        pr.setRedirect(true);
        return pr;
    }

	public List<Object> getSingleData(){
		Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint('https://jsonplaceholder.typicode.com/posts?id=' + Apexpages.currentPage().getParameters().get('postId'));
		request.setMethod('GET');
		HttpResponse response = http.send(request);
		if (response.getStatusCode() == 200){
			List<Object> results = (List<Object>)JSON.deserializeUntyped(response.getBody());
			return results;
		} else{
			return null;
		}
	}
}