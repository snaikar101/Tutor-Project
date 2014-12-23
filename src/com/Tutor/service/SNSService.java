package com.Tutor.service;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.security.Signature;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import org.apache.commons.codec.binary.Base64;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.ClasspathPropertiesFileCredentialsProvider;
import com.amazonaws.auth.PropertiesCredentials;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.services.dynamodbv2.model.ComparisonOperator;
import com.amazonaws.services.dynamodbv2.model.Condition;
import com.amazonaws.services.dynamodbv2.model.QueryRequest;
import com.amazonaws.services.dynamodbv2.model.QueryResult;
import com.amazonaws.services.dynamodbv2.model.ScanRequest;
import com.amazonaws.services.dynamodbv2.model.ScanResult;
import com.amazonaws.services.sns.AmazonSNSClient;
import com.amazonaws.services.sns.model.ConfirmSubscriptionRequest;
import com.amazonaws.services.sns.model.ConfirmSubscriptionResult;
import com.amazonaws.services.sns.model.CreateTopicRequest;
import com.amazonaws.services.sns.model.CreateTopicResult;
import com.amazonaws.services.sns.model.DeleteTopicRequest;
import com.amazonaws.services.sns.model.PublishRequest;
import com.amazonaws.services.sns.model.PublishResult;
import com.amazonaws.services.sns.model.SubscribeRequest;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class SNSService {	
	
	//create a new SNS client and set endpoint
	static AmazonSNSClient snsClient = new AmazonSNSClient(getPropertiesCredentials());	
	
	static String topicArn = "arn:aws:sns:us-east-1:618473455847:TweetNotifications";
	
	static PropertiesCredentials getPropertiesCredentials(){
		try {
			return new PropertiesCredentials(SNSService.class.getResourceAsStream("AwsCredentials.properties"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
	}
	
	public static String CreateTopic(String user_id)
	{			                          
		snsClient.setRegion(Region.getRegion(Regions.US_EAST_1));
		String tUser_id= String.copyValueOf(user_id.toCharArray());
		tUser_id=tUser_id.replaceAll("[^a-zA-Z0-9]", "");
		CreateTopicRequest createTopicRequest = new CreateTopicRequest(tUser_id);
		CreateTopicResult createTopicResult = snsClient.createTopic(createTopicRequest);
		System.out.println(createTopicResult);
		System.out.println("CreateTopicRequest - " + snsClient.getCachedResponseMetadata(createTopicRequest));
		return createTopicResult.getTopicArn();
	}
	
	public static void DeleteTopic()
	{				
		//delete an SNS topic
		DeleteTopicRequest deleteTopicRequest = new DeleteTopicRequest(topicArn);
		snsClient.deleteTopic(deleteTopicRequest);
		//get request id for DeleteTopicRequest from SNS metadata
		System.out.println("DeleteTopicRequest - " + snsClient.getCachedResponseMetadata(deleteTopicRequest));
	}
	
	public static void Subscribe(String topicArn, String email)
	{ 
		//subscribe to an SNS topic
		SubscribeRequest subRequest = new SubscribeRequest(topicArn, "email", email);
		snsClient.subscribe(subRequest);
		//get request id for SubscribeRequest from SNS metadata
		System.out.println("SubscribeRequest - " + snsClient.getCachedResponseMetadata(subRequest));
		//System.out.println("Check your email and confirm subscription.");
		
		//SubscribeRequest - {AWS_REQUEST_ID=87a99987-ae51-5774-84e4-d5733cb4675e}
	}
	
	public static void Publish(String topicArn,String msg)
	{
		//publish to an SNS topic
		PublishRequest publishRequest = new PublishRequest(topicArn, msg);
		PublishResult publishResult = snsClient.publish(publishRequest);
		//print MessageId of message published to SNS topic
		System.out.println("MessageId - " + publishResult.getMessageId());
	}
			
}
