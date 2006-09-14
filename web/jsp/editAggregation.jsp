<%@ page language="java" isELIgnored="false" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="/tags/struts-html" %>
<%@ taglib prefix="bean" uri="/tags/struts-bean" %>
<%@ taglib prefix="tc-webtag" uri="/tags/tc-webtags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
	<title><bean:message key="OnlineReviewApp.title" /></title>

	<!-- TopCoder CSS -->
	<link type="text/css" rel="stylesheet" href="../css/style.css" />
	<link type="text/css" rel="stylesheet" href="../css/coders.css" />
	<link type="text/css" rel="stylesheet" href="../css/stats.css" />
	<link type="text/css" rel="stylesheet" href="../css/tcStyles.css" />

	<!-- CSS and JS by Petar -->
	<link type="text/css" rel="stylesheet" href="../css/new_styles.css" />
	<script language="JavaScript" type="text/javascript" src="../scripts/rollovers.js"><!-- @ --></script>
</head>

<body>
	<jsp:include page="../includes/inc_header.jsp" />
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<!-- Left Column Begins-->
			<td width="180"><jsp:include page="../includes/inc_leftnav.jsp" /></td>
			<!-- Left Column Ends -->

			<!-- Gutter Begins -->
			<td width="15"><img src="../i/clear.gif" width="15" height="1" border="0" /></td>
			<!-- Gutter Ends -->

			<!-- Center Column Begins -->
			<td class="bodyText">
				<jsp:include page="../includes/project/project_tabs.jsp" />

				<div id="mainMiddleContent">
					<div style="padding: 11px 6px 9px 0px;">
						<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table1">
							<tr>
								<td>
									<table cellspacing="0" cellpadding="0" border="0">
										<tr valign="middle">
											<td><img src="../i/${categoryIconName}" border="0" /></td>
											<td><img src="../i/${rootCatalogIcon}" alt="${rootCatalogName}" border="0" /></td>
											<td>
												<span class="bodyTitle">${project.allProperties["Project Name"]}</span>
												<c:if test='${!(empty project.allProperties["Project Version"])}'>
													<font size="4"><bean:message key="global.version" />
														${project.allProperties["Project Version"]}</font>
												</c:if>
											</td>
										</tr>
									</table>
								</td>
								<td align="right" valign="top">
									<a href="javascript:showAll();"><bean:message key="global.expandAll" /></a>&#160;|
									<a href="javascript:hideAll();"><bean:message key="global.collapseAll" /></a>
								</td>
							</tr>
						</table>
					</div>

					&nbsp;<b><bean:message key="editReview.Submission" /></b> ${sid} (<tc-webtag:handle coderId="${submitterId}" context="component" />)<br />
					&nbsp;<b><bean:message key="editReview.MyRole" /></b> ${myRole}<br />
					<h3><bean:message key="editReview.EditAggregation.title" /></h3>

					<html:form action="/actions/SaveAggregation">
						<html:hidden property="method" value="saveAggregation" />
						<html:hidden property="rid" value="${review.id}" />

						<c:set var="itemIdx" value="0" />
						<c:set var="globalCommentIdx" value="0" />
						<c:set var="globalResponseIdx" value="0" />

						<c:forEach items="${scorecardTemplate.allGroups}" var="group" varStatus="groupStatus">
							<table cellpadding="0" border="0" width="100%" class="scorecard" style="border-collapse:collapse;">
								<tr>
									<td class="title" colspan="7">${group.name}</td>
								</tr>
								<c:forEach items="${group.allSections}" var="section" varStatus="sectionStatus">
									<tr>
										<td class="subheader" width="100%" colspan="7">${section.name}</td>
									</tr>
									<c:forEach items="${section.allQuestions}" var="question" varStatus="questionStatus">
										<tr class="light">
											<td class="value" colspan="7">
												<div class="showText" id="shortQ_${itemIdx}">
													<a href="javascript:toggleDisplay('shortQ_${itemIdx}');toggleDisplay('longQ_${itemIdx}');" class="statLink"><html:img src="../i/plus.gif" altKey="global.plus.alt" border="0" /></a>
													<b><bean:message key="editReview.Question.title" /> ${groupStatus.index + 1}.${sectionStatus.index + 1}.${questionStatus.index + 1}</b>
													${question.description}
												</div>
												<div class="hideText" id="longQ_${itemIdx}">
													<a href="javascript:toggleDisplay('shortQ_${itemIdx}');toggleDisplay('longQ_${itemIdx}');" class="statLink"><html:img src="../i/minus.gif" altKey="global.minus.alt" border="0" /></a>
													<b><bean:message key="editReview.Question.title" /> ${groupStatus.index + 1}.${sectionStatus.index + 1}.${questionStatus.index + 1}</b>
													${question.description}<br />
													${question.guideline}
												</div>
											</td>
										</tr>
										<tr>
											<td class="header"><bean:message key="editReview.EditAggregation.Reviewer" /></td>
											<td class="headerC"><bean:message key="editReview.EditAggregation.CommentNumber" /></td>
											<td class="header"><bean:message key="editReview.EditAggregation.Response" /></td>
											<td class="header"><bean:message key="editReview.EditAggregation.Type" /></td>
											<td class="header"><bean:message key="AggregationItemStatus.Rejected" /></td>
											<td class="header"><bean:message key="AggregationItemStatus.Accepted" /></td>
											<td class="header"><bean:message key="AggregationItemStatus.Duplicate" /></td>
										</tr>

										<c:forEach items="${review.allItems}" var="item" varStatus="itemStatus">
											<c:set var="commentNum" value="1" />
											<c:if test="${item.question == question.id}">
												<c:forEach items="${item.allComments}" var="comment" varStatus="commentStatus">
													<c:set var="commentType" value="${comment.commentType.name}" />
													<c:if test='${(commentType == "Required") || (commentType == "Recommended") || (commentType == "Comment")}'>
														<tr class="dark">
															<td class="value">
																<c:if test="${commentStatus.index == 0}">
																	<c:forEach items="${reviewResources}" var="resource">
																		<c:if test="${resource.id == comment.author}">
																			<tc-webtag:handle coderId='${resource.allProperties["External Reference ID"]}' context="component" /><br />
																		</c:if>
																	</c:forEach>
																	<c:forEach items="${reviews}" var="subReview">
																		<c:if test="${subReview.author == comment.author}">
																			<html:link page="/actions/ViewReview.do?method=viewReview&rid=${subReview.id}"><bean:message key="editReview.EditAggregation.ViewReview" /></html:link>
																		</c:if>
																	</c:forEach>
																</c:if>
															</td>
															<td class="valueC">${commentNum}</td>
															<td class="value" width="85%">
																<b><bean:message key="editReview.EditAggregation.ReviewerResponse" /></b>
																${comment.comment}<br />
																<c:if test="${commentStatus.index == lastCommentIdxs[itemStatus.index]}">
																	<div style="padding-top:4px;">
																		<b><bean:message key="editReview.EditAggregation.ResponseText" /></b><br />
																		<html:textarea rows="2" property="aggregator_response[${globalResponseIdx}]" cols="20" styleClass="inputTextBox" />
																	</div>
																	<c:set var="globalResponseIdx" value="${globalResponseIdx + 1}" />
																</c:if>
															</td>
															<td class="value">
																<html:select size="1" property="aggregator_response_type[${globalCommentIdx}]" styleClass="inputBox">
																	<c:forEach items="${allCommentTypes}" var="commentType">
																		<html:option value="${commentType.id}">${commentType.name}</html:option>
																	</c:forEach>
																</html:select>
															</td>
															<td class="valueC"><html:radio value="Rejected" property="aggregate_function[${globalCommentIdx}]" /></td>
															<td class="valueC"><html:radio value="Accepted" property="aggregate_function[${globalCommentIdx}]" /></td>
															<td class="valueC"><html:radio value="Duplicate" property="aggregate_function[${globalCommentIdx}]" /></td>
														</tr>

														<c:set var="commentNum" value="${commentNum + 1}" />
														<c:set var="globalCommentIdx" value="${globalCommentIdx + 1}" />
													</c:if>
												</c:forEach>
											</c:if>
										</c:forEach>
									</c:forEach>

									<c:set var="itemIdx" value="${itemIdx + 1}" />
								</c:forEach>
								<c:if test="${groupStatus.index == scorecardTemplate.numberOfGroups - 1}">
									<tr>
										<td class="lastRowTD" colspan="7"><!-- @ --></td>
									</tr>
								</c:if>
							</table>
						</c:forEach><br />

						<div align="right">
							<html:hidden property="save" value="" />
							<html:image onclick="javascript:this.form.save.value='submit';" srcKey="editReview.Button.SaveAndCommit.img" altKey="editReview.Button.SaveAndCommit.alt" border="0" />&#160;
							<html:image onclick="javascript:this.form.save.value='save';" srcKey="editReview.Button.SaveForLater.img" altKey="editReview.Button.SaveForLater.alt" border="0" />&#160;
							<html:image onclick="javascript:this.form.save.value='preview';" srcKey="editReview.Button.Preview.img" altKey="editReview.Button.Preview.alt" border="0" />
						</div>
					</html:form>
				</div>
				<br /><br />
			</td>
			<!-- Center Column Ends -->

			<!-- Gutter -->
			<td width="15"><img src="../i/clear.gif" width="25" height="1" border="0" /></td>
			<!-- Gutter Ends -->

			<!-- Gutter -->
			<td width="2"><img src="../i/clear.gif" width="2" height="1" border="0" /></td>
			<!-- Gutter Ends -->
		</tr>
	</table>

	<jsp:include page="../includes/inc_footer.jsp" />
</body>
</html>