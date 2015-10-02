<%-- CPS 595 Final project: Lei Ling, Jorge Nieto, Pinxia Ye --%>
<%@ page import="classes.*" %> 
<%! String title = "RedHawk Music - Music List";%>
<%@ include file="../global/header.jsp"%>
<%@ include file="../global/left.jsp"%>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*, java.util.*, java.text.*, java.util.Formatter"%>
<%


String stringID;
Catalog catalog = new Catalog();
ServletContext sc = getServletContext();
String path = sc.getRealPath("catalog/catalog.ser");

try{
	catalog = DeserializeCatalog.deserialize(catalog, path);	
}catch(IOException ioe){
	System.out.println(ioe.getMessage());
}



%>
<%-- Begin Content --%>
	
		
		<div class="list">
			
			<%if(guest){%>
				<p>Only RedHawk Music members have access to a personal music list. Please <a href="sign-in.jsp">sign in</a> or <a href="sign-up">sign up</a>.</p>
				
			<%}else{
			%>
				<div class="des">
				<h2><%=showUser%>'s music list</h2>
				<span>All of your previous orders will be displayed here.</span>
			</div>
				<%
					ArrayList<Order> orderlist = user.getOrder();
					if(orderlist == null || orderlist.size() == 0){
						%>
							<p>You have not purchased any music here yet.</p>
					<%}else{%>
						<table class="song-list">
							<thead>
								<tr>
									<td>Song Name</td>
									<td>Artist</td>
									<td>Length</td>
									<td></td>
									<td></td>
								</tr>
							</thead>
						<tbody>
						
						<%
						for(int i = 0; i < orderlist.size(); i++){
							Order thisOrder = orderlist.get(i);
							ArrayList<Items> itemlist = thisOrder.getItem();
							if(itemlist != null && itemlist.size() > 0){
								for(int j = 0; j < itemlist.size(); j++){
									Items item = itemlist.get(j);
									if(item instanceof Album){
										Album album = (Album)item;
										List<Song> songlist = album.getAlbum();
										ListIterator<Song> it = songlist.listIterator();
											while(it.hasNext()){
												Song aSong = it.next();
												String songId = aSong.getidS();
												int initial = 0;
												try{
													initial = (Integer.parseInt(songId)) / 100;
												}catch(NumberFormatException nfe){
													System.out.println(nfe.getMessage());
												}
										%>
											<tr>
												<td><%=aSong.getSname()%></td>
												<td><%=aSong.getSartist()%></td>
												<td><%=aSong.getStime()%></td>
												<td><a href="../soundDownload/<%=initial%>00/<%=songId%>.mp3" ><div id="dl-button-song">stream</div></a></td>
												<td><a href="../soundDownload/<%=initial%>00/<%=songId%>.mp3" download><div id="dl-button-song">download</div></a></td>
											</tr>
											<%
											}//end of while album loop
									}else if(item instanceof Song){
										Song song = (Song)item;
										String songId = song.getidS();
										int initial = 0;
										try{
											initial = (Integer.parseInt(songId)) / 100;
										}catch(NumberFormatException nfe){
											System.out.println(nfe.getMessage());
										}
										%>
											<tr>
												<td><%=song.getSname()%></td>
												<td><%=song.getSartist()%></td>
												<td><%=song.getStime()%></td>
												<td><a href="../soundDownload/<%=initial%>00/<%=songId%>.mp3" ><div id="dl-button-song">stream</div></a></td>
												<td><a href="../soundDownload/<%=initial%>00/<%=songId%>.mp3" download><div id="dl-button-song">download</div></a></td>
											</tr>	
											<%
									}else if(item instanceof Video){
										Video video = (Video)item;
										String videoId = video.getidV();
										int initial = 0;
										try{
											initial = (Integer.parseInt(videoId)) / 100;
										}catch(NumberFormatException nfe){
											System.out.println(nfe.getMessage());
										}
										%>
											<tr>
												<td><%=video.getVname()%></td>
												<td><%=video.getVartist()%></td>
												<td>Video</td>
												<td><a href="../soundDownload/<%=initial%>00/<%=videoId%>.mp3" ><div id="dl-button-song">stream</div></a></td>
												<td><a href="../soundDownload/<%=initial%>00/<%=videoId%>.mp3" download><div id="dl-button-song">download</div></a></td>
											</tr>	
											<%
									}else{
										
										
									}//end of item instanceof
								}//end of itemlist while loop
								
							}//end of if the itemlist is null
						}//end of orderlist while loop
						%>
					</tbody>
				</table>
							
							
							<%
					}//end of orderlist if
					%>
			<%} //end of if guest
					%>
			
		<div id='back'><a href="<%= request.getHeader("referer") %>">go back</a></div>
		</div>
		
<%-- End Content --%>
	
	
<%@ include file="../global/footer.jsp"%>