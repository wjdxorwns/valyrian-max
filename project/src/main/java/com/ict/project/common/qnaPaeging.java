package com.ict.project.common;

import org.springframework.stereotype.Component;

@Component
public class QnaPaeging {

		//현재 페이지
		private int nowPage=1;
		//현재 블록
		private int nowBlock=1;
		
		//한페이지당 게시물의 수 
		private int numPerPage =10;
		//한블록당 게시물의 수
		private int pagePerBlock = 5;
		
		private int totalRecord = 0;
		//전체 페이지 수
		private int totalPage =0;
		
		//전체 블록의수
		private int totalBlock =0;
		
		//한번에 가져올 게시물을 처리할 수 있는 변수
		private int offset =0;
		
		//한번에 가져올 블록의 시작과 끝
		private int beginBlock =0;
		private int endBlock =0;
		
		public int getNowPage() {
			return nowPage;
		}
		public void setNowPage(int nowPage) {
			this.nowPage = nowPage;
		}
		public int getNowBlock() {
			return nowBlock;
		}
		public void setNowBlock(int nowBlock) {
			this.nowBlock = nowBlock;
		}
		public int getNumPerPage() {
			return numPerPage;
		}
		public void setNumPerPage(int numPerPage) {
			this.numPerPage = numPerPage;
		}
		public int getPagePerBlock() {
			return pagePerBlock;
		}
		public void setPagePerBlock(int pagePerBlock) {
			this.pagePerBlock = pagePerBlock;
		}
		public int getTotalRecord() {
			return totalRecord;
		}
		public void setTotalRecord(int totalRecord) {
			this.totalRecord = totalRecord;
		}
		public int getTotalPage() {
			return totalPage;
		}
		public void setTotalPage(int totalPage) {
			this.totalPage = totalPage;
		}
		public int getTotalBlock() {
			return totalBlock;
		}
		public void setTotalBlock(int totalBlock) {
			this.totalBlock = totalBlock;
		}
		public int getOffset() {
			return offset;
		}
		public void setOffset(int offset) {
			this.offset = offset;
		}
		public int getBeginBlock() {
			return beginBlock;
		}
		public void setBeginBlock(int beginBlock) {
			this.beginBlock = beginBlock;
		}
		public int getEndBlock() {
			return endBlock;
		}
		public void setEndBlock(int endBlock) {
			this.endBlock = endBlock;
		}
		
}
