package com.example.spancer_spring_demo;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import java.util.Random;

@RestController
public class HelloController {

	private final Random random = new Random();
	private int requestCount = 0;

	@RequestMapping("/")
	public ResponseEntity<String> index() {
		requestCount++;
		int randomValue = random.nextInt(100);
		
		System.out.println("Request #" + requestCount + " - Random value: " + randomValue);
		
		// 20% 機率拋出異常
		if (randomValue < 20) {
			if (randomValue < 10) {
				throw new RuntimeException("隨機運行時異常 - Request #" + requestCount);
			} else {
				throw new IllegalStateException("隨機狀態異常 - Request #" + requestCount);
			}
		}
		
		// 30% 機率回傳非 200 狀態碼
		if (randomValue >= 20 && randomValue < 50) {
			if (randomValue < 30) {
				return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					.body("400 Bad Request - Request #" + requestCount);
			} else if (randomValue < 40) {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("500 Internal Server Error - Request #" + requestCount);
			} else {
				return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
					.body("503 Service Unavailable - Request #" + requestCount);
			}
		}
		
		// 50% 機率正常回傳 200
		return ResponseEntity.ok("Greetings from Spring Boot! Spencer Hsieh - Request #" + requestCount);
	}

}
