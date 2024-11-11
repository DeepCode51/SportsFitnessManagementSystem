package com.stern.pojo;

import java.util.ArrayList;
import java.util.List;

public class ClassExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table class
     *
     * @mbg.generated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table class
     *
     * @mbg.generated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table class
     *
     * @mbg.generated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table class
     *
     * @mbg.generated
     */
    public ClassExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table class
     *
     * @mbg.generated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table class
     *
     * @mbg.generated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table class
     *
     * @mbg.generated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table class
     *
     * @mbg.generated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table class
     *
     * @mbg.generated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table class
     *
     * @mbg.generated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table class
     *
     * @mbg.generated
     */
    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table class
     *
     * @mbg.generated
     */
    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table class
     *
     * @mbg.generated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table class
     *
     * @mbg.generated
     */
    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table class
     *
     * @mbg.generated
     */
    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andClassidIsNull() {
            addCriterion("classid is null");
            return (Criteria) this;
        }

        public Criteria andClassidIsNotNull() {
            addCriterion("classid is not null");
            return (Criteria) this;
        }

        public Criteria andClassidEqualTo(Integer value) {
            addCriterion("classid =", value, "classid");
            return (Criteria) this;
        }

        public Criteria andClassidNotEqualTo(Integer value) {
            addCriterion("classid <>", value, "classid");
            return (Criteria) this;
        }

        public Criteria andClassidGreaterThan(Integer value) {
            addCriterion("classid >", value, "classid");
            return (Criteria) this;
        }

        public Criteria andClassidGreaterThanOrEqualTo(Integer value) {
            addCriterion("classid >=", value, "classid");
            return (Criteria) this;
        }

        public Criteria andClassidLessThan(Integer value) {
            addCriterion("classid <", value, "classid");
            return (Criteria) this;
        }

        public Criteria andClassidLessThanOrEqualTo(Integer value) {
            addCriterion("classid <=", value, "classid");
            return (Criteria) this;
        }

        public Criteria andClassidIn(List<Integer> values) {
            addCriterion("classid in", values, "classid");
            return (Criteria) this;
        }

        public Criteria andClassidNotIn(List<Integer> values) {
            addCriterion("classid not in", values, "classid");
            return (Criteria) this;
        }

        public Criteria andClassidBetween(Integer value1, Integer value2) {
            addCriterion("classid between", value1, value2, "classid");
            return (Criteria) this;
        }

        public Criteria andClassidNotBetween(Integer value1, Integer value2) {
            addCriterion("classid not between", value1, value2, "classid");
            return (Criteria) this;
        }

        public Criteria andCourseIdIsNull() {
            addCriterion("course_id is null");
            return (Criteria) this;
        }

        public Criteria andCourseIdIsNotNull() {
            addCriterion("course_id is not null");
            return (Criteria) this;
        }

        public Criteria andCourseIdEqualTo(Integer value) {
            addCriterion("course_id =", value, "courseId");
            return (Criteria) this;
        }

        public Criteria andCourseIdNotEqualTo(Integer value) {
            addCriterion("course_id <>", value, "courseId");
            return (Criteria) this;
        }

        public Criteria andCourseIdGreaterThan(Integer value) {
            addCriterion("course_id >", value, "courseId");
            return (Criteria) this;
        }

        public Criteria andCourseIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("course_id >=", value, "courseId");
            return (Criteria) this;
        }

        public Criteria andCourseIdLessThan(Integer value) {
            addCriterion("course_id <", value, "courseId");
            return (Criteria) this;
        }

        public Criteria andCourseIdLessThanOrEqualTo(Integer value) {
            addCriterion("course_id <=", value, "courseId");
            return (Criteria) this;
        }

        public Criteria andCourseIdIn(List<Integer> values) {
            addCriterion("course_id in", values, "courseId");
            return (Criteria) this;
        }

        public Criteria andCourseIdNotIn(List<Integer> values) {
            addCriterion("course_id not in", values, "courseId");
            return (Criteria) this;
        }

        public Criteria andCourseIdBetween(Integer value1, Integer value2) {
            addCriterion("course_id between", value1, value2, "courseId");
            return (Criteria) this;
        }

        public Criteria andCourseIdNotBetween(Integer value1, Integer value2) {
            addCriterion("course_id not between", value1, value2, "courseId");
            return (Criteria) this;
        }

        public Criteria andClasstimeIsNull() {
            addCriterion("classtime is null");
            return (Criteria) this;
        }

        public Criteria andClasstimeIsNotNull() {
            addCriterion("classtime is not null");
            return (Criteria) this;
        }

        public Criteria andClasstimeEqualTo(String value) {
            addCriterion("classtime =", value, "classtime");
            return (Criteria) this;
        }

        public Criteria andClasstimeNotEqualTo(String value) {
            addCriterion("classtime <>", value, "classtime");
            return (Criteria) this;
        }

        public Criteria andClasstimeGreaterThan(String value) {
            addCriterion("classtime >", value, "classtime");
            return (Criteria) this;
        }

        public Criteria andClasstimeGreaterThanOrEqualTo(String value) {
            addCriterion("classtime >=", value, "classtime");
            return (Criteria) this;
        }

        public Criteria andClasstimeLessThan(String value) {
            addCriterion("classtime <", value, "classtime");
            return (Criteria) this;
        }

        public Criteria andClasstimeLessThanOrEqualTo(String value) {
            addCriterion("classtime <=", value, "classtime");
            return (Criteria) this;
        }

        public Criteria andClasstimeLike(String value) {
            addCriterion("classtime like", value, "classtime");
            return (Criteria) this;
        }

        public Criteria andClasstimeNotLike(String value) {
            addCriterion("classtime not like", value, "classtime");
            return (Criteria) this;
        }

        public Criteria andClasstimeIn(List<String> values) {
            addCriterion("classtime in", values, "classtime");
            return (Criteria) this;
        }

        public Criteria andClasstimeNotIn(List<String> values) {
            addCriterion("classtime not in", values, "classtime");
            return (Criteria) this;
        }

        public Criteria andClasstimeBetween(String value1, String value2) {
            addCriterion("classtime between", value1, value2, "classtime");
            return (Criteria) this;
        }

        public Criteria andClasstimeNotBetween(String value1, String value2) {
            addCriterion("classtime not between", value1, value2, "classtime");
            return (Criteria) this;
        }

        public Criteria andEmplIdIsNull() {
            addCriterion("empl_id is null");
            return (Criteria) this;
        }

        public Criteria andEmplIdIsNotNull() {
            addCriterion("empl_id is not null");
            return (Criteria) this;
        }

        public Criteria andEmplIdEqualTo(Integer value) {
            addCriterion("empl_id =", value, "emplId");
            return (Criteria) this;
        }

        public Criteria andEmplIdNotEqualTo(Integer value) {
            addCriterion("empl_id <>", value, "emplId");
            return (Criteria) this;
        }

        public Criteria andEmplIdGreaterThan(Integer value) {
            addCriterion("empl_id >", value, "emplId");
            return (Criteria) this;
        }

        public Criteria andEmplIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("empl_id >=", value, "emplId");
            return (Criteria) this;
        }

        public Criteria andEmplIdLessThan(Integer value) {
            addCriterion("empl_id <", value, "emplId");
            return (Criteria) this;
        }

        public Criteria andEmplIdLessThanOrEqualTo(Integer value) {
            addCriterion("empl_id <=", value, "emplId");
            return (Criteria) this;
        }

        public Criteria andEmplIdIn(List<Integer> values) {
            addCriterion("empl_id in", values, "emplId");
            return (Criteria) this;
        }

        public Criteria andEmplIdNotIn(List<Integer> values) {
            addCriterion("empl_id not in", values, "emplId");
            return (Criteria) this;
        }

        public Criteria andEmplIdBetween(Integer value1, Integer value2) {
            addCriterion("empl_id between", value1, value2, "emplId");
            return (Criteria) this;
        }

        public Criteria andEmplIdNotBetween(Integer value1, Integer value2) {
            addCriterion("empl_id not between", value1, value2, "emplId");
            return (Criteria) this;
        }

        public Criteria andClassvolumeIsNull() {
            addCriterion("classvolume is null");
            return (Criteria) this;
        }

        public Criteria andClassvolumeIsNotNull() {
            addCriterion("classvolume is not null");
            return (Criteria) this;
        }

        public Criteria andClassvolumeEqualTo(Integer value) {
            addCriterion("classvolume =", value, "classvolume");
            return (Criteria) this;
        }

        public Criteria andClassvolumeNotEqualTo(Integer value) {
            addCriterion("classvolume <>", value, "classvolume");
            return (Criteria) this;
        }

        public Criteria andClassvolumeGreaterThan(Integer value) {
            addCriterion("classvolume >", value, "classvolume");
            return (Criteria) this;
        }

        public Criteria andClassvolumeGreaterThanOrEqualTo(Integer value) {
            addCriterion("classvolume >=", value, "classvolume");
            return (Criteria) this;
        }

        public Criteria andClassvolumeLessThan(Integer value) {
            addCriterion("classvolume <", value, "classvolume");
            return (Criteria) this;
        }

        public Criteria andClassvolumeLessThanOrEqualTo(Integer value) {
            addCriterion("classvolume <=", value, "classvolume");
            return (Criteria) this;
        }

        public Criteria andClassvolumeIn(List<Integer> values) {
            addCriterion("classvolume in", values, "classvolume");
            return (Criteria) this;
        }

        public Criteria andClassvolumeNotIn(List<Integer> values) {
            addCriterion("classvolume not in", values, "classvolume");
            return (Criteria) this;
        }

        public Criteria andClassvolumeBetween(Integer value1, Integer value2) {
            addCriterion("classvolume between", value1, value2, "classvolume");
            return (Criteria) this;
        }

        public Criteria andClassvolumeNotBetween(Integer value1, Integer value2) {
            addCriterion("classvolume not between", value1, value2, "classvolume");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table class
     *
     * @mbg.generated do_not_delete_during_merge
     */
    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table class
     *
     * @mbg.generated
     */
    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}